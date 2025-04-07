Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D921C9FD
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051521; cv=none; b=Lu5dhgPRPX1SpVzB7G26htiNai7ic1xXmHXyohosKyehcr6oNGNBuU879A604oX0L/RVTk+0dI/hgVcEfd6t6F2Zq9cRyM13Sr7CDpnYce4S5QQBUXGrPFwAC9FiEnTFJAT9UuR0emLId2f77JaHUtDkmM1MNjC7tfaVT8Kb2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051521; c=relaxed/simple;
	bh=PgikKRs46m9TKHYsWtcHGXIrCkcscWlTAKZRcjtqc58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMBhRaIITUMBSpjtyoot9mm+WiLVq9sDhZwJzIICkEUDJDMeEYqIyGHQNczRI0f+u9X2OeEsQ4aWyeYjcC7OOI8ggp499+OBx8BkG39VHZ7HBCIfRmne14GTC8O0bU+uRWow4gCVN0sWmv0mzuYbXSlErZwpshU002cOtnU5TmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RKhKlcM+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RKhKlcM+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537IX0jo010472
	for <linux-hardening@vger.kernel.org>; Mon, 7 Apr 2025 18:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CaTgF4a/34uclFeoWrPsrCmEq+pEEC8fdHAghCe2wqE=; b=RKhKlcM+kETrjZEK
	ii/p/I2zsOR5eV4qkbUZayHag9cccq8DlQ/ss0XDIHXyPLFijVzbVwboYSRHn/bF
	/4Bhh6C2OG9jyIEvc53xmttfM8K28dpYWCS8tCmSgevphF5IlTKsCk996YV7Ef+R
	V+u90ApRTSnVZl5H1/XxkDiOCwo1iw3S0Ss5EDGtRuOCOQS8l02hi3HUOzgGM3JB
	dF/9SyViyYyzIdmZt2wodBhJTwbpDqW1fLdGK7YjfZLTXVHSJmbVIW9gKIzLDIU2
	B6qanyKB/lWWlOeRkXYuSAX5w82eImG3NTKhl84G248pmuRHmedw+mAo2kcMTC7y
	I/hHlQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2n84k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 07 Apr 2025 18:45:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so3746741a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Apr 2025 11:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051518; x=1744656318;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaTgF4a/34uclFeoWrPsrCmEq+pEEC8fdHAghCe2wqE=;
        b=Qqy6GiXOeo67uAHW1SQj62eutRjtRqNObad5wxVDlLqujG4AhcnmIUTkmS8GR/KyVZ
         LcX8TpJhDFiopC1N1n7XWiegJNs5hBIWc14d5aPu5X0e9J6a0K47Aopxc8Z4K0YJlQK0
         XYgrE2EgC6ooJB0Esw1YbGzt4NWQJrR6TsCaR2nmEENHRIaNFMM/VvOKzV6THDNCqGdp
         6UeWkWGx7aS0LEGA5ineEQADvWn2Urpz2tbyJ7TnrDiptxwPeMdmCa9lTdNmO167n9el
         H2euMnCrr/8BNOzndkwWC7G3VRw/ix9HHVpxMmXoFg36y5NgnKF65Je5Qgw2tJ8Dyk3h
         TFmw==
X-Forwarded-Encrypted: i=1; AJvYcCXR4n39P44+8o2uZbu5sar6X2kpXOBQ4+AVnNiBZp2Ft1miQ/oa49XQH+qciHXrepKW2qZug5sLDSHfr5S7RnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytuu0l/YMQSzvdXjxJ+vVU6AwRkArJLQ6i8ySM6LIk2Gnwl0Oi
	Fv9rshtNJNbXFVkp/KxI+NUYnkTaUrcGu0aTPK7m4QuVLHMsh7muu2C4994TzfTfXthBjG6saco
	Q5fvNxc+TCp4ybSyCd+REIxIQHnd8qRejqudTcnUNnVh6z0TvwZ4rg6BI3pLR+CWbrQc=
X-Gm-Gg: ASbGnctm8VGdKNx3CyuSyGQ8qejDk+n5MR7eRE2+CyrcSm7fN+KCvqWojBDLQEQdo5t
	Z5r/XYZwNcVd3f7J9jXuaI8/+oinuhCuyadBQW+dusBqsJGURpN0xrxDaYDhy+gdHsSxSL7g99z
	l7tXPU+7G0H+lcKxgYl3kR0FUsT3jISefGpJkjT+Tlz/UbA+dYoF6RmGe7+drek/Vckt6Cuip1L
	X5Y9aJz1TOJSRgvd+zMeMS2QNBFh2iwMubS5Tyttv704oGhvDcHgHauQS/2z3ew/MDHRHoIV20e
	ZgLQGK7M+U0Yu07k+EvR1EfNWm1uxEICX3bVc+dS4Bdt9gQZGQmKwV5o5/k63ERng/usfHh5aEw
	a2xAos1HF
X-Received: by 2002:a17:90b:6cf:b0:306:b593:455e with SMTP id 98e67ed59e1d1-306d0be3b60mr680203a91.1.1744051517641;
        Mon, 07 Apr 2025 11:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH27ifd9SidaNf0mMnrpXJ3YfkJFEZ9H05V+CJJvNNT8LXGl1cdmrGIclx6qauZey72sUoYvQ==
X-Received: by 2002:a17:90b:6cf:b0:306:b593:455e with SMTP id 98e67ed59e1d1-306d0be3b60mr680176a91.1.1744051517273;
        Mon, 07 Apr 2025 11:45:17 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb90bedsm9449695a91.43.2025.04.07.11.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 11:45:17 -0700 (PDT)
Message-ID: <620d7c53-e8eb-4816-a9c2-d4bcd44b5d96@oss.qualcomm.com>
Date: Mon, 7 Apr 2025 11:45:15 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: ath12k: core.h: Avoid
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <Z8-Snz86Xfwdlyd7@kspp> <202504071138.98D5B6E@keescook>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <202504071138.98D5B6E@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zZZal_S9l-oWPQQUeLYcNJPuWuIZzeRC
X-Proofpoint-GUID: zZZal_S9l-oWPQQUeLYcNJPuWuIZzeRC
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f41d3e cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=uvMg_fejPkrpZwH_nmEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070130

On 4/7/2025 11:39 AM, Kees Cook wrote:
> On Tue, Mar 11, 2025 at 12:02:15PM +1030, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct ieee80211_chanctx_conf` is a flexible structure --a
>> structure that contains a flexible-array member.
>>
>> Fix 30 of the following warnings:
>>
>> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Hi, just checking in on this patch. Is some adjustment needed for this
> to land?
> 
> Thanks!

There is an alternate solution which should land in the next iteration of
linux-next (I just enabled the post-merge-window flow from ath-next)

https://lore.kernel.org/all/20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com/

/jeff
