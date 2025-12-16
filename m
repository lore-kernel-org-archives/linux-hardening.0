Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3F2DF138
	for <linux-hardening@vger.kernel.org>; Tue, 16 Dec 2025 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854029; cv=none; b=RordhVI5XfQmCAyxnasiNHzSN4NFY/zf1FJ5eMCgRdm2W7kdTuTThGBrn7mTNiFtFpq3Qc8WHkSVc76ts9fDhyg429ZJL6jzo4dTGwdIaPkHf6y8rUl3Kv7+Aa51tyPUvzZ+5SAePTwQx7Fo7O+3gWQL65bcFM29qNdgnYN3Wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854029; c=relaxed/simple;
	bh=nSNHqt3Dath+fYr+MNVMjbKePREvVtOoT4gZgfyJKbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHJ/7qFZKs9CO/uDZCfSfCYVjHA6vzlNV9BIQxwOmrsT3OnYY5Y4Emi/fNhocPa36B2FWoYJVIwm9hXV2ua0/W1d9x3FTBY7PpB0qmV5vzrp5hPZWVFjgOAyXbU2SeSPu0/khwyimflkbqosg/vhlms1MD/VyARE3I1cBr2cbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=gF4/mIzU; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gF4/mIzU"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id VAPTvkj4BVCBNVLISv15CO; Tue, 16 Dec 2025 03:00:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id VLIRvUIvwqfpWVLISv9Uyw; Tue, 16 Dec 2025 03:00:20 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=6940cb44
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=5TVvHJhSY-PbQlZ89gMA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PsjzeEqvjX0PgDjgXUpv1lzs6nM5Lg9h/IvyfHZ2a9g=; b=gF4/mIzUYheUAddQQ9l/51rh5m
	B75Ctq5Fr2WsH8McbRrMs6MhX0N3fQ0XDvVaTL8vTohXLvjp90M57J4vwWaQTCU26/2mA34F6cQux
	G37STXArEsf9MFajWPtsp5hUhQhOKBdGCaT8/Cyh0daHEXgLycVfM4x13oq+fBa2Dqxux/8MpMSFm
	b8gd3qPBh8Eyy14BmqsKeyWsSXque44g4XkU0g/uZ06ajLGlpnE+KgpcUsGKZ372UAHgdtVJbSoOk
	O7OFDp6opQdkpVKoQX8Kf1azFXz+wbbm0p2oqhl7IbBRZiu9DHYNdelV6dlRx+PXFclUcHWx7Jg1c
	ficOHYbA==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:62552 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vVLIR-00000001Tqd-1dwi;
	Mon, 15 Dec 2025 21:00:19 -0600
Message-ID: <8aa5928f-4338-4ab5-a144-e6ab3b9644d6@embeddedor.com>
Date: Tue, 16 Dec 2025 11:59:50 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hyperv: Avoid -Wflex-array-member-not-at-end
 warning
To: Wei Liu <wei.liu@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aTu54qH2iHLKScRW@kspp>
 <20251215184759.GA654575@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251215184759.GA654575@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vVLIR-00000001Tqd-1dwi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:62552
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPUaGa/nUNoIKQI+W9OuDN4EByX5EZWnUvrtrBPxaGP7Wi5evue0lGAmjpY4RLtZJeEkr+U/EKRtGMWu0zhF2OJirNsUjcmaFV/V/CcNmY88Tid4Q6yB
 f6E8XHBDKqwQZlsrohl1qPayHwar+/uPhiQarvIlRLHzYQQMG9nDHNAXC2ojUN87ttOKwVbSt2Ml9YNcvVBfdA+5c0dAxMZD+zsq78iOhTHx2MRFFkih8vcK



On 12/16/25 03:47, Wei Liu wrote:
> On Fri, Dec 12, 2025 at 03:44:50PM +0900, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new __TRAILING_OVERLAP() helper to fix the following warning:
>>
>> include/hyperv/hvgdk_mini.h:581:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM) and a
>> set of MEMBERS that would otherwise follow it.
>>
>> This overlays the trailing MEMBER u64 gva_list[]; onto the FAM
>> struct hv_tlb_flush_ex::hv_vp_set.bank_contents[], while keeping
>> the FAM and the start of MEMBER aligned.
>>
>> The static_assert() ensures this alignment remains, and it's
>> intentionally placed inmediately after the related structure --no
>> blank line in between.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Gustavo, what is your build command? I would like to incorporate that
> into my own build tests.

I'm using the following patch (which is the one I'll actually submit
upstream once all these warnings are fixed).

diff --git a/Makefile b/Makefile
index e404e4767944..0d6a0d8f791b 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,6 +1086,8 @@ KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
  # Allow including a tagged struct or union anonymously in another struct/union.
  KBUILD_CFLAGS += -fms-extensions

+KBUILD_CFLAGS += $(call cc-option, -Wflex-array-member-not-at-end)
+
  # disable invalid "can't wrap" optimizations for signed / pointers
  KBUILD_CFLAGS  += -fno-strict-overflow


Thanks
-Gustavo

> 
> Thanks,
> Wei
> 
>> ---
>>   include/hyperv/hvgdk_mini.h | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index 04b18d0e37af..30fbbde81c5c 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -578,9 +578,12 @@ struct hv_tlb_flush {	 /* HV_INPUT_FLUSH_VIRTUAL_ADDRESS_LIST */
>>   struct hv_tlb_flush_ex {
>>   	u64 address_space;
>>   	u64 flags;
>> -	struct hv_vpset hv_vp_set;
>> -	u64 gva_list[];
>> +	__TRAILING_OVERLAP(struct hv_vpset, hv_vp_set, bank_contents, __packed,
>> +		u64 gva_list[];
>> +	);
>>   } __packed;
>> +static_assert(offsetof(struct hv_tlb_flush_ex, hv_vp_set.bank_contents) ==
>> +	      offsetof(struct hv_tlb_flush_ex, gva_list));
>>   
>>   struct ms_hyperv_tsc_page {	 /* HV_REFERENCE_TSC_PAGE */
>>   	volatile u32 tsc_sequence;
>> -- 
>> 2.43.0
>>

