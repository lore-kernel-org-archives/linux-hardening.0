Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72622E612B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438509; cv=none; b=XpvM/QHsKO2i1dqiKZGCFSSmU/Ur/8hYrY4QgmR6tvZeG9wnzLUPNGOjmZhHEkIH863r6yk029nfAKH4BajhiC8vI92wXSvI4aaVFRowdJUubU5GblTbWwP4+brIOLbFvqGeqAki2kJxB3Sa5Vbocn7hzySg6JIpHWbMa1LJYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438509; c=relaxed/simple;
	bh=2PjTMHy5F3iPIngcSswDszD1rmfKQu+pVIhzm5QlxFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+Z5XG2YPTMZSI0X0eHps4yCAV0iiTEHy+kP7ugp33vD7ECH9BO/rSP0apsqKRoRNFytf2foyoEF/eWUoPRkm4sECmMVZNynVK1762LuU/ixJwZxxkb4N1tMUFTS1eDKJz1lYJNOTatNM8KvbRai5E0Lf1xdfqX7w5MP0xLudiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mL52/1Jg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mL52/1Jg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KFwkli004735
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 16:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y2I2QseFJ0gr5gYIqnnWqNCwwaaSonPDD1prW4PD/A4=; b=mL52/1JgJoGggS/i
	4nE0Id8O6uM8LFH1ZMyXi7NeB3vdT6P8lbIFSEnmBwu3rzG4TnYW0rxA1xFxS3+W
	A/Tgk4sn8UFRyQIW5n1uqiNNwDDdajBTWa2ZlgRkISB42kKMQHJ5ABp1jctCXIGQ
	YCyslYKe/DLbQDQqKginB7+66PmR7fFYeEEYjqFvt2uuK+TectPsye++pn+Qq89H
	pREE28Mh/QbYDV6DvduAzzu2dEf1oMN8lpyGHtb1hAol/MKMhteC6rA0/WCCOLM/
	PbJJ4dGYl6lVD6j2NN6fzToXbDNkYYk9QsolwWP2uYfkXWPXr9N+QEwMRSxULpk8
	UAx32w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47darvr4h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 16:55:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fadeceb4c9so4196506d6.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 09:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438505; x=1751043305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2I2QseFJ0gr5gYIqnnWqNCwwaaSonPDD1prW4PD/A4=;
        b=LMotUqSZjaLoi4MCkpMOxoNEhh9PVkm8+BR/PAxp00C6uLWpIqpYjXDQzsmC7/Xpy0
         e+aFtjZIUqwwsjbHnX8S7zixENn0o9Pyg0mba4IqDE2dGbUmBBQbS4Zo8/SN89lxeTcD
         30nOz/nx47kUFkdmkbA6W9G6kWKX26LLx4SYgVoAORn1M0qE14RL9rCfW9y07M6lZqGa
         eKS9o8rw2BG8WmIKv7c6i9/ICi4nmiIGeQKiPQz51XtUdogWrSmVX1pYBUj14Ui6aZWA
         etGqiioTsHr+IYCkbJW8CDaYOOc3tUhLiFeWd9UNX8C+lP17g7g6hkmxkJWka+mT9Nfw
         R38A==
X-Forwarded-Encrypted: i=1; AJvYcCVAwBByHvDCsNhjotLSAWqeCRuQvvJm7wQm19bdAvXqy/RkyOe7i5YS+JfYGynJDFVyMtBZPtXeh6H7+5LUvIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysT6tcvTI24qdEnKEshQeFhf91UVVL4DTI/ML5kNWAXIY0Dags
	ToPk0sNPQEmQwFJdd2HCEh2YBUp1o88WfKJwqu3ugQY4Xetb4MnGjLrboFGQpHP95YFyrQu2A5l
	TrEsf0k9hQY+S5o7vlGzs2ChqW4x21VzmyryyNiCypSWylGpFZSez4yETt/xqrLKhLo1rUtk=
X-Gm-Gg: ASbGncvakVMCXVLt4jEcN0IOuAHBaCOH188keN9HPzDz9V4jvHXOKlQ4gwjyusGSdL5
	VcW/zjoiOHAYBxsgo4/4UzvoEu2QIKOvt/XnUWqKL7x8hBrv6JdOLu4hBCxbUq84Hs5p91avskG
	Edog1W2JScIZCdfzilMhGDF4naPMhWSbGMNkOA0IPuDLdRT+9keOy3UZ1maOjXah88dBeLfFBTB
	sKZRcAeqP8NKm3zQ0xkfKluEoUnosq8WGgP0SezO+yr1ZBA/xqFc5LYBFG70kTXcOs8IlnxeGSl
	dBvUQz50m21pTXDW4pWDoeTRNs1I9vm6ZYlj3oKx5/PbzOw343e37jWaIUxDGsfQY93u0v2mUJq
	xdVA=
X-Received: by 2002:a05:620a:1a84:b0:7c0:c42a:707d with SMTP id af79cd13be357-7d3f993a910mr185107685a.15.1750438505193;
        Fri, 20 Jun 2025 09:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzroywSyK0lLak+kmGhL7I4nUbTDl//l0+nE20iSxOE4K84JZ9jklmLuZwJGAH+b1r8H4Iyw==
X-Received: by 2002:a05:620a:1a84:b0:7c0:c42a:707d with SMTP id af79cd13be357-7d3f993a910mr185105185a.15.1750438504725;
        Fri, 20 Jun 2025 09:55:04 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1857c124sm1603889a12.36.2025.06.20.09.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 09:55:01 -0700 (PDT)
Message-ID: <2864033f-5f1d-4026-9bed-6a79ca917701@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 18:54:57 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] power: supply: qcom_smbx: allow disabling charging
To: Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PEGKWqzZROU4NAdhwZDCA80ym3AK6ew5
X-Proofpoint-GUID: PEGKWqzZROU4NAdhwZDCA80ym3AK6ew5
X-Authority-Analysis: v=2.4 cv=YrgPR5YX c=1 sm=1 tr=0 ts=6855926a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=XZI00cIVyT1STSWTZ2QA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExOSBTYWx0ZWRfX7XN9Ql9gZ2Ay
 WXS7Ee8VbNKdqCbtMHazOn6IcXGpSwbBLO/aFtSVEZ4s2DdjzaTQCkNy8BgS6CRyxptzUrC5roo
 L7cLIXEAeyViK/7ND96QWwRXSDZEICCmAbXwQ2jhZ39B7Ypnejvz6ag1+chCCfTyI/TlApuJDDk
 RHHTFUOCVrEVUnF/2YklQ5O0G2LAkleIn2Sf798ZiCzNi7fjk3gVRt8HLoc+5kjoxluSt13quPW
 Edi/1y6VMSLlioL1vN0zCf0GnJXuGjVLRcBLUa/NKxOHdQMfTOcrCU2VUOG8fuHRQlrKgdw6dKh
 Lx97P32NddKYF++IpZfhFn3acq6JIoqhq0h0A/SQqQdojo4Ks9a4uT3DNlCyFzm0z0WElroN2L2
 BHIwIzisCfVn4kL309N9vL2lGWFYnYsXYGzJK2NQHVkNSlRRAFhb1MK85K01W8lraLGeTv/l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=791 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200119

On 6/19/25 4:55 PM, Casey Connolly wrote:
> Hook up USBIN_CMD_IL so that writing "0" to the status register will
> disable charging, this is useful to let users limit charging
> automatically.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
