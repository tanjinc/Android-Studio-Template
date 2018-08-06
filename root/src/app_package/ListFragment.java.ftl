package ${packageName};

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>
import ${packageName}.bean.${beanClassName};

import java.util.List;

public class ${className} extends Fragment implements ${contractClassName}.View{

    private RecyclerView mRecyclerView;
    private SwipeRefreshLayout mSwipeRefreshLayout;
    private ${adapterClassName} mAdapter;
    private ${contractClassName}.Presenter mPresenter;


    public ${className}() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.${fragment_layout_list}, container, false);
        mAdapter = new ${adapterClassName}();
        mRecyclerView = (RecyclerView)view.findViewById(R.id.recycler_view);
        mRecyclerView.setLayoutManager(new LinearLayoutManager(getContext(), LinearLayoutManager.VERTICAL, false));
        mRecyclerView.setAdapter(mAdapter);
        mRecyclerView.addOnScrollListener(new RecyclerView.OnScrollListener() {
            int lastVisibleItem;
            @Override
            public void onScrollStateChanged(@NonNull RecyclerView recyclerView, int newState) {
                super.onScrollStateChanged(recyclerView, newState);
                //判断RecyclerView的状态 是空闲时，且是最后一个可见的item时才加载
                if (newState == RecyclerView.SCROLL_STATE_IDLE && lastVisibleItem+1 == mAdapter.getItemCount()) {
                    mPresenter.loadMore${objectKind}();
                }
            }

            @Override
            public void onScrolled(@NonNull RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);
                LinearLayoutManager layoutManager = (LinearLayoutManager) recyclerView.getLayoutManager();
                //The last visible item
                if (layoutManager != null) {
                    lastVisibleItem=layoutManager.findLastVisibleItemPosition();
                }
            }
        });
        mSwipeRefreshLayout = (SwipeRefreshLayout)view.findViewById(R.id.refreshLayout);
        mSwipeRefreshLayout.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                mPresenter.refresh();
            }
        });
        mPresenter.load${objectKind}(); 
        return view;
    }

    @Override
    public void show${objectKind}List(List<${beanClassName}> dataList, boolean isAppend) {
        if (isAppend) {
            mAdapter.addFootItems(dataList);
        } else {
            mAdapter.setData(dataList);
        }
        mSwipeRefreshLayout.setRefreshing(false);
    }

    @Override
    public void setPresenter(${contractClassName}.Presenter presenter) {
        mPresenter = presenter;
    }
}
