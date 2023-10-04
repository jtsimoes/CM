package cm.homework1

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val resultTextView: TextView = findViewById(R.id.display)

        val callButton: Button = findViewById(R.id.callButton)
        callButton.setOnClickListener {
            // Code for call button
            dialPhoneNumber(resultTextView.text.toString())
        }

        val deleteButton: Button = findViewById(R.id.deleteButton)
        deleteButton.setOnClickListener {
            // Code for delete button
            if (resultTextView.length() != 0)
                resultTextView.text = resultTextView.text.toString().substring(0, resultTextView.length() - 1)
        }
        deleteButton.setOnLongClickListener {
            resultTextView.text = ""
            true
        }

        val oneButton: TextView = findViewById(R.id.one)
        val twoButton: TextView = findViewById(R.id.two)
        val threeButton: TextView = findViewById(R.id.three)
        val fourButton: TextView = findViewById(R.id.four)
        val fiveButton: TextView = findViewById(R.id.five)
        val sixButton: TextView = findViewById(R.id.six)
        val sevenButton: TextView = findViewById(R.id.seven)
        val eightButton: TextView = findViewById(R.id.eight)
        val nineButton: TextView = findViewById(R.id.nine)
        val zeroButton: TextView = findViewById(R.id.zero)
        val starButton: TextView = findViewById(R.id.star)
        val hashtagButton: TextView = findViewById(R.id.hashtag)
        oneButton.setOnClickListener {
            addNumber(oneButton.text.toString())
        }
        twoButton.setOnClickListener {
            addNumber(twoButton.text.toString())
        }
        threeButton.setOnClickListener {
            addNumber(threeButton.text.toString())
        }
        fourButton.setOnClickListener {
            addNumber(fourButton.text.toString())
        }
        fiveButton.setOnClickListener {
            addNumber(fiveButton.text.toString())
        }
        sixButton.setOnClickListener {
            addNumber(sixButton.text.toString())
        }
        sevenButton.setOnClickListener {
            addNumber(sevenButton.text.toString())
        }
        eightButton.setOnClickListener {
            addNumber(eightButton.text.toString())
        }
        nineButton.setOnClickListener {
            addNumber(nineButton.text.toString())
        }
        zeroButton.setOnClickListener {
            addNumber(zeroButton.text.toString())
        }
        starButton.setOnClickListener {
            addNumber(starButton.text.toString())
        }
        hashtagButton.setOnClickListener {
            addNumber(hashtagButton.text.toString())
        }
    }

    private fun dialPhoneNumber(phoneNumber: String) {
        val data: Uri = if (phoneNumber.length == 9)
                Uri.parse("tel:+351$phoneNumber")
            else
                Uri.parse("tel:$phoneNumber")
        val intent = Intent(Intent.ACTION_DIAL, data)
        startActivity(intent)
    }

    private fun addNumber(number: String) {
        val resultTextView: TextView = findViewById(R.id.display)
        resultTextView.text = resultTextView.text.toString() + number
    }

}