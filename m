Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B382C3251
	for <linux-hardening@vger.kernel.org>; Wed, 22 Apr 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843214; cv=none; b=d46HipfQdbb0hReW94Wqn4R8a04ONkMlH9dp+x1yBAcHFJ4IBzMX9xHyV9Z66aMXCimzreAxZfbGBPGZ5WX8XQhp4xO1tN0bLdsh/M88GRa1ECsOUGVGlYl/dY5s1tRMFLxbE0ELSe8GOzH4ibv5uvj5bE7WVlvesHfqiv+xB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843214; c=relaxed/simple;
	bh=aosl6rV15/wreA5xMI1XS6wi+BXhDQdDzUmn7iC0RKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0ikjZAuUFsMGjaRjGPEe1Y3+5HlAgQZA1TfhVbtUYS5MFYOeEbijMaG07P8Ouqv9HBwfutjUXPnbqBk5P8UoHGGGRb9SCSztou0Z7HgJCN1Aie6ck2KFm6O2AKou/DcrNVie/YNP5weF17+bKhkwVATyOt90rcop8KwbOIo5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JN6QJcNP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hGAJezH9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JN6QJcNP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGAJezH9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M4n0bj2000978
	for <linux-hardening@vger.kernel.org>; Wed, 22 Apr 2026 07:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUHf8ulEiPw7CaBhxw+DUSr/H4AXtAj3Vn1bkVwKjM4=; b=JN6QJcNPFGSKj+78
	XiCWi1bqDNVZWHSqDBDU+yezOJy7lMxooxtOpdjBPbcvbzPtjKnxRXHypSFI28JO
	NhO7T/lfPRkFsJLXGbV7c/Gwk9Ojv3gZkg2Lpbyswsj/lsqFfBQ5sZz2+DgnMDw0
	CTSF31oADr+O6R4yxcMI22jPLelQ31jd0/P37ihhXRbPyG97p2naCEJhb7gKI58W
	p0+3bjGWVLGB7M5grKGV4ASsFfURrigZ83jo9PX820rw4IC62Dt+tvNrnAiAogPS
	p/QtCT4ljmTh+TiNA1sSPYgmzJSkRjnu2NOM1TdFzDx/RmiLpsgEkItePBBBduIw
	pxch9Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfab5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 22 Apr 2026 07:33:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4654f9bb6so54342205ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 22 Apr 2026 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776843211; x=1777448011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUHf8ulEiPw7CaBhxw+DUSr/H4AXtAj3Vn1bkVwKjM4=;
        b=hGAJezH9ai/PTnkzSQXduPQTkoS2/ztWq5+eYps9ievTmD5m+wofK2/YzjOr0p71S4
         mxe0fCp3Pe2qvvefrDSRKyrCQWx1OFWh1KbQhIplFTpEPUq+LXZkxMli9RDXTJYQ0y4S
         8sjhn29LnXMb60ftuGyiRETlAA5dKb9chIQZHHQHLcQC4YP88jQVgwhKm5wbUyLDFPih
         xq487LWNjyX4XGrSOwFiI+OmVa7ecJsUcL/774zROZ5RqmhrxXv0H+O0vzbNg+8NH7IT
         LPv2MfDRuN9pRKnO6R8z8/E6Py4I5A9fhrU9OrgLANN8MlBd6SoRDBEggYhU5fd9+5MT
         n5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843211; x=1777448011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUHf8ulEiPw7CaBhxw+DUSr/H4AXtAj3Vn1bkVwKjM4=;
        b=rQvMQKrPBKe8jylML+4K65JMf9A2/6MHiasPZvADGNovfsGyHQz6G+FoISZmPscs+b
         WWxZnhuTjUw26kk6ge9ldAj0UHcHm7lx6f/9N7i9lcraJgaK1qACRYirFXsML52xWHoe
         bZtUN+9TodUjBx/FgkT/WuR3M08xxzfP/+2NXWW/SF5m1xDLv9JkLO3Pm80a+IWBg4/K
         gh+kOLYPBdQbivBkriUDOq9yV4VQrAmeU4Y8shNd4xWQbX113KeOLYazY+9F8ljU4ws5
         5taR0R0c4u08AOO4sHdEOLNSj2uqjZHr1GuTjmfXYD38sOX0lB7KKjqsNHFOXDnCHEM1
         EBEA==
X-Forwarded-Encrypted: i=1; AFNElJ9Kk4v7fQKe/9hX7Kv1ZF+BiEh3W//tyBaC5iBJ5pcNDfUDZXbQnoav7xlgiDf8qZ60HxrBB0XWmcCHRYPKZ90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZWIfCmScQLEDzNZ/VuB77xsC0ugyPUgpKbvy0r+j+iKSUkR+
	vYKUjzN5Hzisx2oBw6PjZa7CahYAoR0YbvGRAPVvCLCUmujaeMUq5VUiSKWpE/zKvLLCIhIDGH4
	WR1ldE5jtV/qaSecZTqYODD7AQAt97TrvVYusw16OAilUrTXIp/5SY/t+/XAq5OC4hca5CfI=
X-Gm-Gg: AeBDietT7/IhGgkV2O3JHvtBjOpfgrE8oqKs7vfvA/PsbzLCVEgYrDGYI9Oq4Jq7MT8
	NS+ohFKjyVhj12olnHbZd1TekOYARfzWJdjXYTbrxyr6crAZvtr+7AsF0D41nImKEgj9NEV/BC5
	IkjdiNeSGliBgLok+P3XYJPGkVI75Q0Pcd9hDaEzDXwXEr2nG+4rgz4NMQA9pQjt5Hfwoa5TObM
	Q/CjqNSDmKPA6+88nknVeI9qu1m6+LZuxhmWgxyQ8Hmg6EsUQFq5Dj4BLBDvPaBuP5BseyP5Wr6
	xF4u49wtjESOfUFoGR/YO+qgFSG3w9yFfDIBhNFDbVSUVg7eQmoRGvc5gJzIjoV0VJ/KWucHELE
	tvJJPNDdcl0FYY4+Td5Clu+Wtt2zXVhuib+fToKE9ir2rBu/ViWvanijDcW97q2oTTXolVpk4
X-Received: by 2002:a17:903:3dad:b0:2b4:5dff:310f with SMTP id d9443c01a7336-2b5f9fcf868mr132251725ad.34.1776843210792;
        Wed, 22 Apr 2026 00:33:30 -0700 (PDT)
X-Received: by 2002:a17:903:3dad:b0:2b4:5dff:310f with SMTP id d9443c01a7336-2b5f9fcf868mr132251575ad.34.1776843210296;
        Wed, 22 Apr 2026 00:33:30 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff8d6sm148998515ad.1.2026.04.22.00.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:33:29 -0700 (PDT)
Message-ID: <48ec0ab3-96f7-449f-a1a5-d1e76a3cb139@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 13:03:25 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 ath-next] wifi: ath12k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATH12K WIRELESS DRIVER" <ath12k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260421213544.6238-1-rosenp@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260421213544.6238-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Pv4a5q9voOSMth7K820-g86d6NB5sIyF
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e879cb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA3MCBTYWx0ZWRfX9DtXTa7vY101
 TR6nit5XDtFhIGGBMQ0tG6D05J0P0I3JBS84cdgI1HseWvOeebvL6AP+Z51ufhSNvWoE1q7MGFt
 4P1vyzZvUO/ImD9CJBUF9DkrKjaMbohHw1GPpeJF4QUzBBn7H1UT4AAj6wQxhi+v99azCy0x5cM
 SLFzP+yD0JOx+t+qZIsoM6srrR3FP2YEn1e0vjFh+K6imL4KkynVP+KyLAuh0VxpkSsMqnabY4q
 wQuocUwJp2K/e+ISAvQuiulxjKbtUv/+v7fgKYYQdTnhrgqCURwImmDRZkg8nCFemeH6p2z/38V
 Ky0ZtBWVcJ/UixW+WXEHEozcx01RXlLWT6Mbq2HmYIxRx4U/vcuBC6WlrMibbC/Md1NhaF/bxeE
 0FgOyjd0QgI6OBJ6ABkKuRcNwo8HmaKJo5QeasO+lRGFzGp7XN3gNoVXUPxecaMAMWGHuKyoeUq
 MeHghn4haLkdmafUJ8g==
X-Proofpoint-GUID: Pv4a5q9voOSMth7K820-g86d6NB5sIyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220070

On 4/22/2026 3:05 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
