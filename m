Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510372080EE
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186601; cv=none; b=iZFiIlq9cTefUgFy09SFHbKmB47ajLdKufhELZ+7YG6Yj0DE0WCJ7GiiXs5z1b2i/Pbh7KCbD2H7YUOf0iJ7TTGbQtNBnjtu0LZeNjUulqnyABdurDmbEqDPn6wFNo78C1lkn8gTvLis1iBwITYGtw6prl24a+L0bor1NAhiP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186601; c=relaxed/simple;
	bh=OHdQtfx+uuhnWp1sTD1WAzlOAjtZAJhksJYh+ZhNzno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCgGYCCNbP0qLVoS2geORGwe1dFviyi31G0eTreInlWUriLKIByFYBKahLFKRVl5Rqus5PmeJpieNmVfKHaHQ9vVoEP/hsGnPRlmSP4hslHvms6oLCZk1bWrnaKGzkdCXoxI3IMUQzpvSCcYhz1vO/SZuaYxe/4t7OCSNESByy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=at7X4qYe; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="at7X4qYe"
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id tHzttWmP0Afjwu2IKt9yFe; Mon, 17 Mar 2025 04:41:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id u2IJtgimfGFuBu2IJtEnK5; Mon, 17 Mar 2025 04:41:43 +0000
X-Authority-Analysis: v=2.4 cv=I69jRsgg c=1 sm=1 tr=0 ts=67d7a807
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=BLCW4eN0VRAnxn5/FNkZeA==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10
 a=aqjusoyMyk9cqG8RMkgA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qagcm+b9ADxCwFZUPtxgdLD7LayhL+I77jhLGCR+kCQ=; b=at7X4qYe1cbeLW5Bm0KmR2/31F
	zlVNX4nzxQcvP5RbjR/r6GYC84+JLo3YEG8lHcTLDLbKl/xzV5PUMp91TSy8qYoz0Kz7PJz4oYs2R
	wSe91x1ktjzIcdNAyiJA5WX6srJldV4oGRjXTzqjP/EVjFxqmPB3IkjaGDDUVptbwBNMp6WfhxUkB
	tAzK0MfEehYo5NB1w0ZVZvaRNxFW67PH16QXHgrMnOUp2D22O6rk1s4dKc0C6QlN2xwN/4MlVEn9O
	v/rHdEQbpCU17zOtEAYHB2mdTrcFuYu+ldHvOI13TH2Lsxivc3vwC8nC7cD4hqRIiqfoZN1JKx7sN
	lCI0E2ww==;
Received: from [129.127.202.110] (port=50746 helo=[192.168.225.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tu2IH-00000000dxd-3LUv;
	Sun, 16 Mar 2025 23:41:42 -0500
Message-ID: <112490dd-4490-44f4-abd2-07f7a519aa7b@embeddedor.com>
Date: Mon, 17 Mar 2025 15:10:38 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: cros_ec: Avoid -Wflex-array-member-not-at-end
 warning
To: Tzung-Bi Shih <tzungbi@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z9dy43vUUh4goi-Q@kspp> <Z9d7rp-ullvmXKoM@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z9d7rp-ullvmXKoM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 129.127.202.110
X-Source-L: No
X-Exim-ID: 1tu2IH-00000000dxd-3LUv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.225.44]) [129.127.202.110]:50746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLHD8NsK3Ba2BgKMnhTXuPA2AkdKG8rcjcvFdITzpWSppqfxzKdBdersf0J2eClaAgvk6lR9ucul18dLpSpCuOezyy0p4ZMYNTmHiMmaZqsfKOYmioNa
 YZBt8mj04b6En+i1uE5MUBsuj651SJIVBpQjF8u9Zku/18YE7Ixz36xY3Y76alCg68D/VNvKU3x8rsxzh2LchbXzNHuyDwKOo+EbzXGZd653ht9/1cG+/zf5



On 17/03/25 12:02, Tzung-Bi Shih wrote:
> On Mon, Mar 17, 2025 at 11:24:59AM +1030, Gustavo A. R. Silva wrote:
>>   static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>>   					     u16 cmd_offset, u16 cmd, u32 *mask)
>>   {
>> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
>> +			sizeof(struct ec_response_get_cmd_versions));
> 
> max(sizeof(struct ec_params_get_cmd_versions),
>      sizeof(struct ec_response_get_cmd_versions))?

I considered that, but DEFINE_RAW_FLEX() complains about it due to the

_Static_assert(__builtin_constant_p(count),				\
		       "onstack flex array members require compile-time const count");

--
Gustavo

