package ${packageName};


import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import java.util.ArrayList

import android.widget.TextView

import ${packageName}.bean.${beanClassName}

class ${adapterClassName} : RecyclerView.Adapter<${adapterClassName}.ViewHolder>() {

    private var mDataArray = ArrayList<${beanClassName}>()

    fun setData(items: ArrayList<${beanClassName}>) {
        mDataArray = items
        notifyDataSetChanged()
    }

    fun addFootItems(items: List<${beanClassName}>) {
        mDataArray.addAll(items)
        notifyDataSetChanged()
    }

    fun addHeaderItems(items: List<${beanClassName}>) {
        mDataArray.addAll(0, items)
        notifyDataSetChanged()
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.${fragment_layout}, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.mItemName.text = mDataArray[position].title
    }

    override fun getItemCount(): Int {
        return mDataArray.size
    }

    inner class ViewHolder(mView: View) : RecyclerView.ViewHolder(mView) {
         var mItemName: TextView = mView.findViewById<View>(R.id.item_number) as TextView
    }
}
