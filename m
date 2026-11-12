Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490462;
	b=4/UnMMVGf47Qu5MvCPYgB/W8Fl5izONkxM2NXGYoL19EpjWT/OOIL6CFhi2DWiTFgdGE
	 TInktmXdFGWkf6O/BuuB4eP9/sAW7oO1sitOTCSRh2UZOuiP4ptsmUVx9icnZwMW1MzW2
	 iqKPQ9CWhRwKK/hK3CEKpPMyzeImIP+KcbmbWz/8mMXYEhl3c3x+wEaIKL3eXniwUWedG
	 b/wNOL7W4NvZP/gmMXxypk7K1N9TSvjQE9MmMCzmvdNa0jv7j33rIv13nsF/j8z0eu/+G
	 XboUPG0ii56K8t8bjjVsQiTiPDtlLvo8Y+H+ViQH8to7R8QZFo8nte4IejMY1C3xr5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=;
	b=zeGFIw6Dq//OQQxpZillGBnv2uQx9JrCBMvbiMNz+IOY7VTKw68xEhTW7MGWwfDidoo8
	 7YV0GZirToBIDX7nO+xbnd3AHYKuAAF5CRcaoq/jtUuT/bdBuwV2uP1eOxwrSErydXyIN
	 ljGJquGXlaaIJge8hEGZq2Dg8adBNrOxGPgm2jVD1gG2L44kehluz5x2aWShZF550+bCu
	 OPPrY7/MfOrHCVBGPTgFeRBAkCbwUy8zmfUvmfmevbWEMjaWNPqhRklWvp7qJE5WniGPV
	 rB/eZH66OZ81PgppDBiGpGANFObqs2CwTEZDx512SGtdP9/msvlRiT8BtT+JMrWtl8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hHsGRD7C;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I5jfqXnb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A7606A32A
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 13:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557A7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hHsGRD7C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I5jfqXnb
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC97HDa2514188
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 13:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=; b=hHsGRD7CIheVre2s
	LWP8gjwXgsLt5YhSb8KdPblO0CHJxMoTwEJlliXeohBUyt9bGYvN5fGTChs5iPiS
	6azkvQnMhe7LRyYNcqCZmOhbrLctwwy8iaqRXher5tl5L3Sp4z7bOY4+ar1fBG89
	C3sz4TXbCcUpd4Rnv88Nlc9boMpjcLGZ33AJbW5oYafE0HD2Z2ojpNlFJKQCLXyJ
	MSRib5HXQa7yqSUWkuGy6kyEYnTX9Fg5BE1sAtHEU9KwaWLPba1IM8pUvNJt/SBP
	m5f0x0MZD2RAp5ztCgoj+cN2tcxAA1YwbYVnrw9HmcE4ojEfJh6RHXJwdui7UsBF
	Xjg4kA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1urt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 13:34:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so529112085a.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490460; x=1795095260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=;
        b=I5jfqXnbAu+K5yIZKbvly4xkMmcd+toykRbvoCSRapj5x7z51HZTGvchLU7DY5JlYn
         GO027vlJ2p/OF99J42MLzJjegyOw51yxnm5hlK60NZ5/ROyoJ5shI23iM5QI3oxYzm34
         CBBlNQxGVu+vzj+oHHpemo68g65fIjyV/mfi0/tQVc/KAjN3yBeAWyl8fiQDFIa3iCz2
         pa23+/oy9mxsUk2UrKhJ9ewCwz64MuGmWxKkak6DdjoxWsa4POTORGJ6XQg/vSsx36L9
         AFtXhBkse29ziyqrk1Ps9KVBDP1EnJ4Aa59GG1T1l8C92qRNGfP9Qcl3DN89zpYm+F31
         BfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490460; x=1795095260;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=;
        b=hLYg0QEE6hVDFOP5RKVZyHCrv9tdIY//BRaoYi98rZBleIUQpPDR7dgAqGY5XDbazv
         26uKNm7F6wcqd/5ypG2UGzWDEtePI089BuYPOQNSTyq5Q6Ofh0zaoXCpqvuB04i0g9Sq
         YnV3Zc/jsExVTQt3EFLR0UnaTp19l80zmhU5aA8f4kbvpRoBTOWJNfMmGlt1u6EDAz8/
         q0mdASXFcZp/6pwAaBcMkNyFMZ14zzkdS+5Y45AREDYNdGUX1bE8mlkxWYD9Mf5lDhWg
         G2cCcnYq+da60yClhPiOAuD8QeYxzWosG/15WYkU0nhtFTV72N2QUZhHDOeMwuUGpD7D
         ONbw==
X-Forwarded-Encrypted: i=1; AL+hErEK+x4BOw0rxJ/yVK04HtOAjBetTOr/kPmdDiYTGJowTSyN6uPFGVdcA1Cbd8WPUwplVrBHHRCWJB75BiRqiyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BSwSz+OG3rjwfiNlkf9WT5add2PBUTraaZdBVtgB9GhIYAxmh
	EtLEHwI909ayXeZSBE3cvs25FQjKiC0rluB9WsvlXSX4xynvwd6EU+jJJ8gwr9I7l6QY3uz5uX6
	k624OeTt6hmC7qj1lTLtI7ZvSiOj9eKy6b2nWD3AQ4JmeM0XiYI9rHXJV6+TFePeChSq6Kb0=
X-Gm-Gg: AYBFou3vA9MJXDRs7W6Yd3gzquNPfRc6rmNcszPjyjbBIYiFWTdqA6S+sDJByfwFu6h
	DKYdEDT5O4HNqfncWvDAezLjLSzQiWZbJ8NOMQMnVeT6rArlYeU0ZJIT+kq/07UgB7bR7VE2Gtv
	L6WYFYnBaLWFqzJNaex06of0n6yr2sXCuW0/3Kg3Uv4PmCyoG1fjZ6RfuslGXJIyA8Y4mMYUE93
	wxkwanCagb2ljr26WPTpBvZhR2BdHihMcMM1eKbxkThsaO05WUi9yk+97madnENZKl4OQDcjlDs
	0BfsSUdrhIyqC1UsigBjOSzu/6mj63jto2eRcoi3hKJqKiJrziPuguy5ghZ0OBUsPb5Mo9MntXK
	M+isPAVt69eQaU2bMQgnIqRkhDZpKwJTZOnJgYjbGthJAnLre9x2yjNq7C3kng9aBXONGv6Lanj
	8UWVf0HbqSkYF6aozuJhNvNQa5t1inyWS57LBHpgj17OO+UkTNNDTkgAdl8RsI3VgrvtY2exJzI
	vHXa4AX/P7fbSE00OmTXSvOY3eftOj7l2vz2nvgcxgE
X-Received: by 2002:a05:620a:a01b:b0:948:d833:1bee with SMTP id af79cd13be357-948d83321camr607633685a.3.1794490460309;
        Thu, 12 Nov 2026 05:34:20 -0800 (PST)
X-Received: by 2002:a05:620a:a01b:b0:948:d833:1bee with SMTP id af79cd13be357-948d83321camr607626985a.3.1794490459701;
        Thu, 12 Nov 2026 05:34:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a67ab93sm341707766b.77.2026.11.12.05.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:34:18 -0800 (PST)
Message-ID: <f55dddf1-d745-471a-8001-8f9e5768d97d@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:34:17 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-core: start rtd->num_components at zero
To: Mark Brown <broonie@kernel.org>, Dennis Gilmore <dennis@ausil.us>,
        kees@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, gustavoars@kernel.org,
        linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com, dlechner@baylibre.com, linux-spi@vger.kernel.org,
        miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org
References: <20261112025252.71375-1-dennis@ausil.us>
 <179448342405.66517.5463730214277229760.b4-review@b4>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <179448342405.66517.5463730214277229760.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af5c05d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=dp6IbyjqBwS_WhlRAgoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 7fNRja_AcesCHrFdRydgLegULGK0ROLj
X-Proofpoint-ORIG-GUID: 7fNRja_AcesCHrFdRydgLegULGK0ROLj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX4+GpijgsKiIu
 xIs7SfWzM4UDRrqfAiJbbI04H3o8PksPj8Y/zj6jrGpor9psCO3ZGlAuy+oOGyM/uS04IvbXo9R
 QyDwXJsG7bh8qqJiVka/8IhjIiYaltVaX8PMEhg+nFO5m1bzwRvA6ttNERaqcl3jmR7R7s2kz+D
 S6c8RJr7QeXbtyo3kd5lbke/CEQpWW17hafSr5wjw+n/OxALqM4qsUxXvbboGRAzc1UQnthOKXb
 nIy+VxVUGxMmadKmDhG/kQO0ScNGzzlG/6pBlHa7WzqL5Er1BBDQjUiKLu1OfE9zQjtS7WSz6UR
 RZvxw+ZkPBexsPtcCv4MEZGSq/fVhCE+pX7f61UEOCgdknlp7dh/UXAt565QUB8h5fpkiJV0L3L
 +TGf6ZleinrG9u6TsWWqzck9zvK85hHDLDBndCghaADnAr0G4D5G5ke6UrC5QK5F61VRhdkELQA
 uqWJfSC7tcIDrFdaoEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX6L6MCQhP0rHh
 sYi5d2AI2PMtQn+9EB36ZbZ+w9qzCoe0oilUb8139PmICjQAJ5ONsKWsvKonm5CBKsZ7kCxdBnR
 hyukPjtCjL1e2psOUEQac99iZgLOYtQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120053

Hi Mark,

I was about to send a regression bug report for 7.4-rc2 but I first
checked the list to see if a fix was already available and I'm happy
to report that this fixes things for me:

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

On 12-Nov-26 12:37, Mark Brown wrote:
>> Since the conversion to devm_kzalloc_flex(), the allocator sets the
>> __counted_by() counter num_components to the allocated length
>> (num_cpus + num_codecs + num_platforms). This only happens when the
>> compiler supports __builtin_counted_by_ref() (GCC 16 here). With
>> older compilers the counter stays zero, as before.
> 
> This doesn't apply against current code, I think this is an issue that
> was already fixed.  Please check and resend if it's still needed.

This applies cleanly on 7.4-rc2 and fixes a regression breaking
audio on a lot of different devices there.

If some form of this is already in ASoC-next, then that needs to be
send to Linux as a fix ASAP.

Regards,

Hans

p.s.

@Kees, have you seen Dennis' remark about the same problem with
devm_kzalloc_flex() changing the semantics with the num-components
counter now no longer being initialized to zero in at least 2 other
places? :

"""
Kees, the same pattern (a *_flex() allocation followed by code that uses
the counter as a fill index starting from zero) looks to be present in
two places converted by 69050f8d6d07 ("treewide: Replace kmalloc with
kmalloc_obj for non-scalar types"). I have only read the code for these.
I have no hardware for either and have not reproduced them, so please
treat them as possible issues rather than confirmed bugs:

 - drivers/spi/spi-axi-spi-engine.c: spi_engine_optimize_message()
   allocates p with kzalloc_flex(*p, instructions, p_dry.length + 1),
   which presets p->length, and spi_engine_compile_message() then
   appends with p->length++ through spi_engine_program_add_cmd().

 - drivers/net/wireless/intel/iwlwifi/mld/d3.c:
   iwl_mld_process_netdetect_res() allocates netdetect_info with
   kzalloc_flex(..., matches, n_matches), presetting n_matches, and
   iwl_mld_set_netdetect_info() stores at matches[n_matches] and then
   increments it. The per-match kzalloc_flex(..., channels, n_channels)
   has the same issue with match->n_channels.
"""


