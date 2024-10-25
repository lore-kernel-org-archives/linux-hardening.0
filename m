Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128AF1B21B1
	for <linux-hardening@vger.kernel.org>; Fri, 25 Oct 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888620; cv=none; b=DtiuRhpju8/9OPII/1jNKLtCkL1PZLX48+nYzggQaTKlRGlO6+aNf1kTbcqdO8Yx/oNn8OjMB4/1UOzIV/ylFZ7fpVXCvQ8OUACUD0OPqo7KC5qtOpjyzgIYl34kWOReimEo2jiX9y4XoHOt9qzJ7nhBoeFc8qYwl81uPLJwTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888620; c=relaxed/simple;
	bh=VYBMxqwXMgsrg2pZXoCn+GnZFEkdPmox795KfR3wPwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoEFhy7pLnRjNuyDB2iieEDxEKBoHUp6I2RkidxOlaig94vV1z2Q8fpbhc0SuxmmkO5tuNcdRYOdHInS95sULsM3I8+Zyu9tFU3a1WLome2o25fjaBxzHtNXnEaU/3MYUBig0+umcLygeXC4B5cmLHnMXVRwnzde4ZfPMjo/6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=YbLWLt2A; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="YbLWLt2A"
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 4Me5tkiSbnNFG4R3Dt289y; Fri, 25 Oct 2024 20:36:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4R3CtkgSaO7uS4R3Ctf2up; Fri, 25 Oct 2024 20:36:50 +0000
X-Authority-Analysis: v=2.4 cv=Acy3HWXG c=1 sm=1 tr=0 ts=671c0162
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=mKMXtcfHHMa54xGqesAA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JIXtr/smAzzJVTQu88p4I8Uobao1EUnmCUV2Vs4aLSk=; b=YbLWLt2AcymwsuUAefSHXuVCTB
	vrKsQUqqpC3r06IYYrhm9idH9+9y3q1dxDBNx5nV5fUArPfZg9GyE12pxw6cgy4nabpTpMKeMVde/
	Sr8gunywUdjLKywuR4Xzq9GTjbszGZ+aXkEgjJl2ufZOlTk6qlPGsYfs6EPxBY53LTlQ2JYTbOu9S
	FdIm1HfcxQRebDrYKWPldExzujXPwiMM8W+nNzGIQ7six1ZbQ0jgAaqxZEF8IMXEYcC1OxyODYULx
	BCF/njqB+9Z3B9iWUwqn5C2//LiokLfSxxJwrZwl83HKtXB/Fcf/LIsbh/DUVJYimZJ0AvWcNL7QS
	U30+SN4g==;
Received: from [201.172.173.7] (port=35774 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t4R3B-003Uaa-0P;
	Fri, 25 Oct 2024 15:36:49 -0500
Message-ID: <8152a551-1813-4d44-a203-45d30f2ac671@embeddedor.com>
Date: Fri, 25 Oct 2024 14:36:44 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Johannes Berg <johannes@sipsolutions.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Aditya Kumar Singh <quic_adisi@quicinc.com>
References: <Zxv7KtPEy1kvnTPM@kspp>
 <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
 <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
 <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t4R3B-003Uaa-0P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:35774
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKpsca6I5DPwn8td8R+nXnUGjJaLT3aVAddrPNgN/oS5TshZ5sHcVPiywD+6r4f39UzndUsgiYhgUsZxp2hGhrPn1wiKfRKe2Ht/xrT65mmBPTl1oBhn
 M4K+4JSZ+o056WtoZpAZEWhYo9zy/3buKNv+1816ASlKm3218XeumFxbnQCwywvuc4s/5nQ/0/wM4QxNKDGTdjx3PILzAUaARqPQFuIfDM+gHjvU4ihaT43c



On 25/10/24 14:25, Johannes Berg wrote:
> On Fri, 2024-10-25 at 14:22 -0600, Gustavo A. R. Silva wrote:
>>
>>>> -	struct ieee80211_chanctx_conf conf;
>>>> -
>>>>    	bool radar_detected;
>>>> +
>>>> +	/* MUST be last - ends in a flexible-array member. */
>>>> +	struct ieee80211_chanctx_conf conf;
>>>>    };
>>>
>>> Oi. That's not just a warnings problem, that's actually a pretty stupid
>>> bug, this will surely get used and radar_detected will alias stuff that
>>> the driver puts there - at least for drivers using chanctx_data_size,
>>> which is a couple: ath9k, iwlmvm, mt792x, rwt89 and hwsim.
>>>
>>> Could you resend with a description that this is a bugfix and
>>>
>>> Fixes: bca8bc0399ac ("wifi: mac80211: handle ieee80211_radar_detected() for MLO")
>>
>> Yeah, I was actually going to mention this commit, as it's the one that introduced
>> that `bool radar_detected` to the flex struct. However, it wasn't obvious to me
>> how `struct ieee80211_chanctx_conf conf` could overwrite `radar_detected` as I didn't
>> see `conf->drv_priv` being accessed through `struct struct ieee80211_chanctx_conf`.
> 
> You have to look at the drivers, see hwsim_clear_chanctx_magic() for
> example; I wonder why hwsim_check_chanctx_magic() never caught this.

Sorry, I actually meant through `struct ieee80211_chanctx`. Something like:

struct ieee80211_chanctx *foo;
...

foo->conf.drv_priv[i] = something;

or

struct bar *ptr = (void *)foo->conf->drv_priv;
then write something into *ptr...

In the above cases the code will indeed overwrite `radar_detected`.

> 
>>> please? Or I can do it myself I guess, but ...
>>
>> Sure thing. I can CC stable as well.
> 
> Thanks!
> 
> No need for stable, it got introduced in 6.12-rc1 only.

OK

--
Gustavo
