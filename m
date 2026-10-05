Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FA4D0A15
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217010; cv=none; b=QiVqaT42KklnH/1bsiWDfTmjodnyI6V4PaGdvK9eGwczOyqWcxNlrkYhxKjwoZPOw7s0UoMj5pVqYMMw+DDQ9DSJ98CA7ACECTRifw+1tpJVoKPLsphLLihfKtZWWqZwYKJAKtfax/CGR3wE7frOy/5Y5yFNCQD39VMD1HH7eBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217010; c=relaxed/simple;
	bh=rlLYG6jqv3PimpyLK1/8g/oAhJGjh8GkcrmM4+65O0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUpamRa8BVuEtSynRaeAhGlFSyYig+PipdAoQl43Nay6qye7RQ5YVWkQCSu1ey8+NhjLdI1BErS2HUROTx5j6bctHo1rWqhzQLeyfrfImDT5ajTYrItzFUdbIfbEU+huf6X51yA5SyO4UMwgcgElALGuMhBSLjxxL83OIqAiRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFmv9Aek; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RiwIolWx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFmv9Aek";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RiwIolWx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EPFRn2015266
	for <linux-hardening@vger.kernel.org>; Mon, 5 Oct 2026 16:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zbICt7mq9cvO53jr/TjOqyTHGzuqZGS1C+bnfP8hMfA=; b=dFmv9AekT9ilee3h
	Q3nveQkdbJlIPmH1tso9H5cwNl3V+rb6Q8h2eOFR8Zq+RoOlupkHrt3B/quA3jFF
	QZISzQrk2OW5KmO/iwkrmbTlSy3kGVAmFNl/h28QikmwdGZfC0/X0ouOc7U2son3
	/Rgy/eLcmqYmpDYnvCNVzYfQChzjm3dLbRA0alJyn1RMFUOy9HM3LC5kPmZ8oWW2
	zZD86uLBRWao1MwQ3TX3lGR3ymnRGVi8Ht29BAw5asLxNw/Ikz0LeVLmZg1eBx91
	uMizdNp9tgOfL11FgqpyjQoTkqMSOYEC87isuT/idcurVu2QlXNvQG/TANj4A1Da
	sH9K4g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs2x3m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 16:16:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e5c10f3801so929375ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791217005; x=1791821805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zbICt7mq9cvO53jr/TjOqyTHGzuqZGS1C+bnfP8hMfA=;
        b=RiwIolWxS6YXnyWfYlFR0tprgRryR/IxKTF69zTTyuFWiEG0eqnsw2piqpKJi3odjI
         qN88DCB95xbSblJmJcrFeFbcQLG+SBcbM715cENUddA6EnFdAEfF7uG5INHLWTRXsrsc
         ar4R2Lu+/kaEg25u+EqRos6lU3PPQbgbky3VhkKt4aZ1FU+iXTurBlR6a/7z6W3Zv3G+
         GirnatPwVBqrEQSsBWUW6xBzXDMX3RRGqYUp7BNc4PUIBSUZAT3bNXF/Yi4lIXzpRF0G
         37BkhgCqo5JJTnJQT9xqGMMAi4YnLz2omygnY/ic9edqtNTpJwX6Nja4NJisG0dugZi7
         WbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217005; x=1791821805;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zbICt7mq9cvO53jr/TjOqyTHGzuqZGS1C+bnfP8hMfA=;
        b=ZJncy9fB9asooP1rF3x8U9gGIUUdrsfHAEKCFgSxgTsgovUuFD2c8MXaLS6TusfTIY
         cLbPky9gbVfQUeKXKq+lz4ty81HWEje4p1ttuUp2lub8yC7Dim046pir9PVvC9oD3QS8
         U+7NKGPikCIEgH57wQOLlzAZ3IXXrgSP7+c8NOjQO+QZ23/E9Rb7JJwTaFPzg2XGa9cO
         y8EiG0yAwQmCrHtvf171M0uZti98Aq+uAYWlLmj73QZsbjYJ7hR1aw2RQMhdXydjCIPW
         /rKVkOj1VqdBTKNacgz3HrMjsDeVxO1bwzxSMjEil6pcXnTaWkfKSZZsGqUCbIdAVhzt
         CTpg==
X-Forwarded-Encrypted: i=1; AKwUvBxRsK86nq5Bi494e+bmVXBavH4qy4TGNyNTCXEVApX0taiHJUiAbbIHv5MMmzQo/0G9E+GjbYomG3GDVV5DwKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgz3Z1rEGYeTsvONBFR7IzsQBQMzy/C10JQIJHPy3IiRvAG3lK
	XS/Y/dLRzFNtRz5HfsmNyPzT5EmiSSD3qKikYos6Kpdn7iRRXh7oryrPXcMetNUJ6CMOtWZohXj
	3P7HYhn6hOPDOaWL0MIoPev5ISHJxD/uvZxN662EDItad1/VvD43gQPhjfOsUraxpsomjQQ==
X-Gm-Gg: AYBFou0ZMZ1NysdPpvA1nqVLdwujzHdMquBVi04I+2JdBYls6SYA1w2nTYaMaejqY6I
	R8K7YILV+7PHykchWDCBE7rlO4ObfaMv+6qnz+eRjWvlqu3XNTgrtSSfNyp7puJY0FreHTNtWkI
	G8QJWe2XXU7cso6Kz1wlnAhsZzzzUaqHUT90UAXda0RJsJKY58ynu+u4eD8EMlYxbF7xishw3yT
	T9gacQyO+AelVtIY7Ohpq9Up7c9kwtwXtN8EeKjPzIJ88odvZkzmvFvRQrgc0v+p9C7gChGh0A4
	adPU1lZE4gtFCKmsyHsFPyFFMaOPXs1RmOxBe+QR5ZRXp8C+vo9nfgZ6KrSllnnhGmLKL3gCyLi
	gVplSxtA2BiNe0mLRgurVwi5RncbqudXwqO9ObnLrVRDILugkfmaIHGakI59pzM6tWOnlBE/CAa
	Xba4BL+CJ0HYAWbNsB
X-Received: by 2002:a17:902:d60e:b0:2dd:ad74:ac2d with SMTP id d9443c01a7336-2e5105a5a0amr66701225ad.31.1791217004662;
        Mon, 05 Oct 2026 09:16:44 -0700 (PDT)
X-Received: by 2002:a17:902:d60e:b0:2dd:ad74:ac2d with SMTP id d9443c01a7336-2e5105a5a0amr66700915ad.31.1791217004005;
        Mon, 05 Oct 2026 09:16:44 -0700 (PDT)
Received: from [10.50.23.243] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5cae51asm10191485ad.29.2026.10.05.09.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 09:16:43 -0700 (PDT)
Message-ID: <d90da428-8e4f-405f-968b-062ce136657d@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 21:46:39 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 11/16] wifi: cfg80211/mac80211: Handle
 UHR Link Reconfiguration frame
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
 <20260924-smd-v2-11-bb40094da1d4@oss.qualcomm.com>
 <616e0013e78323cbd6a1a307cd40d59b1e562373.camel@sipsolutions.net>
Content-Language: en-US
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
In-Reply-To: <616e0013e78323cbd6a1a307cd40d59b1e562373.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TbSOu3rcRhDadjxnltwBZVtdgbE4sdhq
X-Proofpoint-GUID: TbSOu3rcRhDadjxnltwBZVtdgbE4sdhq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfXwVaWhczaeazF
 8jnIQQavnzVEN1xIQOSfqRU+mCEUV/FQujkKu6tKrTJA0zXif9f0ftbBEvDGHNNWz/94rFAT5Zy
 pW5cQuYch7L3Z2SGR02DlevLMNwuMys=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfXyCWthPXYRbMA
 FPCDpWPy9yt/sSVrqEA/gYTEgkaFcRJtwSf6WoHbLO9obrnUTJYnR7LGUrGnH28IUlO7TMkUeoP
 NjiaowiSwOpj/C6h2DqFqciu3VV7pTak/gh2j9Se/vZ98q5TUGGegUPLcCqOSTrrsw6iFPOCFVt
 GFjqazLYQ2m67QWF7SZ4jgyoXz6N0qanXpFdosGKu+tBSWt2LPoGXAOxPg0QbSRjWbSiJQ9pA4D
 iVVXYO5jn/WbkyNfQPF80bGQF7UcF7vQy6ZUGakMD96uHlKLIAmBLUQ4rpdIYLA2tFiqeWAGUCY
 ug9UjYXo9pnKz1F/SVhTKgPEH5srn6io1tD2xaHBEHAsR3pWjwRC4T7hh/AbJOzvhHX+/ja4dKW
 KwOhzjiZ7djDd6aKKM+DgY8NH1QcUEkt1O3+0adJWyrLTCLyqAtmLX+J/MpGkAU9LJl9j6+E8XN
 xfTu6ILYVlUPGtX1xLQ==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac3cd6d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=vuaycF0E-hVDLVIvCLkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050063



On 10/04/2026 03:53 pm, Johannes Berg wrote:
> On Thu, 2026-09-24 at 08:10 +0530, Pooventhiran G wrote:
>> A UHR Link Reconfiguration Request frame (ST Preparation or Execution)
>> triggers SMD BSS Transition on the current AP MLD. Userspace needs
>> reporting of the STA's dynamic context along with such frames so that
>> the same can be transported to the target AP MLD for setting up the STA
>> TX and RX queues.
>>
>> Reserve a field in ieee80211_rx_status that enables drivers to attach
>> the STA's dynamic context to the corresponding frame. Since the maximum
>> possible context can grow too big, attach the pointer to the context to
>> the frame. Add handling for UHR ST Preparation and Execution Request
>> frames so that the associated context is propagated through cfg80211 and
>> nl80211 for userspace reporting.
>>
>> Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
>> ---
>>  include/linux/ieee80211-uhr.h | 59 ++++++++++++++++++++++++++
>>  include/net/cfg80211.h        | 13 ++++++
>>  include/net/mac80211.h        | 10 ++++-
>>  net/mac80211/ieee80211_i.h    |  2 +
>>  net/mac80211/rx.c             | 96 +++++++++++++++++++++++++++++--------------
> 
> This change is big due to argument refactoring - better do that
> separately.
> 

Sure, I will split up the patch.

> Also, I think better to combine the whole series a bit differently with
> cfg80211 APIs more isolated and then mac80211 implementation(s)
> 

I will reorder the patches this way.

> One thing I'm missing completely - which is why I was looking for the
> rx.c changes - is handling of 4a substate frame limitations?
> 

I will add the sub-state frame limitations in v3.

> johannes

