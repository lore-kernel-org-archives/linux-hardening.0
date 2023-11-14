Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA082FC43
	for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="f51cZ98K"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBA9D
	for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 13:20:50 -0800 (PST)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id 2vq3rAeY9hqFd30q1rlg4u; Tue, 14 Nov 2023 21:20:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 30q0rWVUVM0U230q0rIB3J; Tue, 14 Nov 2023 21:20:48 +0000
X-Authority-Analysis: v=2.4 cv=BuKOfKb5 c=1 sm=1 tr=0 ts=6553e4b0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=4phrzMesRlFG3ZuAd8AA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fqvdjHSSkvRmHNFL6Pv4n1V2wTIvkAGySUpqtAfFSms=; b=f51cZ98KRhtRisZYT+jer9cNAh
	eWgA4QhUoN0SZBoylMKbOhqG3sBkDA+DrCOZFRj6EupY/7B90kgfO/Kd78IyAavMG0eWqgONbn27S
	dScfs/NVeg4r+f1Bs68pcOEeFrzdBu18v3a+Txn3MtvzPdO8VRviZKuyZPsH4pPB23jImmTRVVJFo
	sy6kH9aNxz8CoXG/3r3fn11KezGgoB4fVzu/ZMqBNduWxlN5kOXZ317VjbdafAiK0iKw3cKdA8AX0
	iXAvqstxxvsXXSfkuPMnzmTaM0YkhQAd2x5fz5xHFZtsocHUHT75z4IYSYqit2M56Kvb24/HjOlHW
	ojLm6raQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:58556 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r30pz-003oHt-2B;
	Tue, 14 Nov 2023 15:20:47 -0600
Message-ID: <c353ba94-0712-422b-bfbb-f166c7690cf8@embeddedor.com>
Date: Tue, 14 Nov 2023 15:20:45 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hwmon: (aspeed-pwm-tacho) Fix -Wstringop-overflow
 warning in aspeed_create_fan_tach_channel()
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZVJ7JBFoULzY3VGx@work>
 <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r30pz-003oHt-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:58556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ4YxWl1iRnT2lpFgnefwVQ5+ovjPpyS6OOdqAKtZGsHteTl3JNPQ/NxjWG8Z4QqBA3ZFeYdwaOqRMZIHoSLAGM5AtRGjI+A37rcLmhgYUurRM9iBtel
 DTlX2o31r36SW/ZV7ieEBlbrrz30X77UErI8hDwJxtuPy8vXiYFvZ3kVuKmt0e1vznIhYc3cfiUbF+DKvpEit/tE2E/IFR3mvhuk/6Y5e6UYCwq1bBF0LnPE



On 11/14/23 08:52, Guenter Roeck wrote:
> On Mon, Nov 13, 2023 at 01:38:12PM -0600, Gustavo A. R. Silva wrote:
>> Based on the documentation below, the maximum number of Fan tach
>> channels is 16:
>>
>> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>>   45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>>   46                 integer value in the range 0 through 15, with 0 indicating
>>   47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>>   48                 At least one Fan tach input channel is required.
>>
>> However, the compiler doesn't know that, and legitimaly warns about a potential
>> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
>> in case `index` takes a value outside the boundaries of the array:
>>
> 
> All that doesn't warrant introducing checkpatch warnings.

Do you mean this?

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#17:
  46                 integer value in the range 0 through 15, with 0 indicating

I honestly didn't consider that relevant, and I didn't want to alter the format of
the Doc text.

However, if you want me to split any offending line, that's not a problem. Just let
me know. :)

> 
>> drivers/hwmon/aspeed-pwm-tacho.c:
>> 179 struct aspeed_pwm_tacho_data {
>> ...
>> 184         bool fan_tach_present[16];
>> ...
>> 193         u8 fan_tach_ch_source[16];
>> ...
>> 196 };
>>
>> In function ‘aspeed_create_fan_tach_channel’,
>>      inlined from ‘aspeed_create_fan’ at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>>      inlined from ‘aspeed_pwm_tacho_probe’ at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
>> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>>    751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>> drivers/hwmon/aspeed-pwm-tacho.c: In function ‘aspeed_pwm_tacho_probe’:
>> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ‘fan_tach_ch_source’ of size 16
>>    193 |         u8 fan_tach_ch_source[16];
>>        |            ^~~~~~~~~~~~~~~~~~
>>
>> Fix this by sanity checking `index` before using it to index arrays of
>> size 16 elements in `struct aspeed_pwm_tacho_data`. Also, and just for
>> completeness, add a `pr_err()` message to display in the unlikely case
>> `0 > index >= 16`.
>>
>> This is probably the last remaining -Wstringop-overflow issue in the
>> kernel, and this patch helps with the ongoing efforts to enable such
>> compiler option globally.
>>
> 
> I am sorry, but this description almost completely misses the point.
> The real issue is that the values in aspeed,fan-tach-ch are not range
> checked, which can cause real problems if is elements are set to values
> larger than 15. This is a real problem and has nothing to do with string
> overflows.

Yeah, the above paragraph was extra, and I removed it in v2[1]. The rest
of the changelog text describes the issue in the code.

> 
> This should use dev_err() (and, yes, that means dev needs to be passed
> as argument), and the function should return -EINVAL if this is
> encountered. Also, error handling should come first.
> 
> 		if (index >= MAX_ASPEED_FAN_TACH_CHANNELS) {
> 			dev_err(dev, "Invalid Fan Tach input channel %u\n.", index);
> 			return -EINVAL;
> 		}

Done in v2.

Thanks a lot for the feedback.
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/ZVPQJIP26dIzRAr6@work/
