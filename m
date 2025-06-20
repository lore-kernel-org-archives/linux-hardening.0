Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B72E613A
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438642; cv=none; b=Ly57hxIKu2KD2ccNRzCDrOLM7Rygo7/RkQ2lY1kUyw6/FXdizF2VuPjDw/rIY/iGwcWvbejjKo6aFSjYEVMxqB1O1lOROeno7kBwT+7Vx9duqh49/ju03GJMOtasERNvgZp7l33m0L8cKs8YQnaXkMNe105OMqcXwhrNR7XNbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438642; c=relaxed/simple;
	bh=MTRrTMjk8gJcugrmcAJwb6WUoNgM0oitaPnoUyoLBzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kja8gsChL5H9nkY6bv35Jw0sdEYUXNkJq1gFJ7IUk0ZZUvk0AY3VOm2yIzKOlz/hvkgI1/LPGvA64BbOhuHKuo+OXxfI7WHna5S0FiOjYXCMUZC8P72cP9vvzRJGCGrTKlHOfL6NTt2b6iYwmgWrNdly/J5OnZXXydW/ZfBfhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAfEnH0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAfEnH0L"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KGaIU7002604
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 16:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aH6iMtS8aVt02x/4hZJymbYmKZmSzX/zk1qluora9rA=; b=oAfEnH0LeNoYXcQg
	pwuWt1tSnKPkXXf4mHqj8b9TJ6Ohyu3Q5HWpqu4/l5sfVdYi8ZcqiWGhGqhWEi2X
	r6wl7sKefFcrg2/DVvRmqLKvuxJjmQryvzXjuWqE7BGa0V3nQBdlnobojfNhf17B
	dqC/FDBjSqqKq9ItL0Q4EeeOubnM9EP8vSz3DtEzWL19aXJ1WiuzsF32jaPk2Lar
	EdadcvY+jANazamAoA3jHCmKQzx2tgSOwXEZ4fVVAgVCs6gvF7SjkE9PokrO+maL
	ywHCBkRsDpWnIZ2St+vNFoslTt7DCdxAB0q4qacwtflCnpWs2DXmb0Bjb/5IBzwG
	AYtQFA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47db9w01ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 16:57:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d097083cc3so57258185a.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 09:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438639; x=1751043439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6iMtS8aVt02x/4hZJymbYmKZmSzX/zk1qluora9rA=;
        b=R6RRfThfd0q95dX4hEB6AHWLgsECokolArRKrcr1pnDd2E9zjiWusrUFqwInqnTBY7
         1ybtnNQzb7Sw+CT2l2J+AkOI4zMbLtjlHOlE00NdZNvdTAJYIILUlZaW6zn2EVeULCxz
         WAjvf4VODjGaBKgNwHne3vatQ6Hnk6hmbzP55Vq31ExcEa92HCuViI3aRZGy307Cevrx
         V8tYmRnftWCzzv7T9wuXhI/aUmP6eKxcV1lBvU0aFCUpkaUQTsJ/2uVukcfYA8gnKAwp
         dNScUcauXU1NQOeqvWrGes2hPxS5XfQrAzHvnPCWq4w9vRCtJC21bn/yBCWNBhv5g/Oo
         jHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd/xkyJOaMhuRwVsnT3axnUq7lmCtJhUrrpyEA3RVxFYXXGHoyLsixlOpXqxKzDDUK/b4Nz2i+/3sbefZj9Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+YK6mDfo2aO8UjTl0JkVnehuvMPOUvs/i7RaJpF1J8aZxnbV
	wB8OvKww8kN7Mz513CDdCLcUuq5a0o6sNU2eYMZzbUCZxJKBQjszelcJO3jNyYGYrKhU99Cr8C9
	i8TIjg2OgtxZcV8R7lBbCbLPCOu1rD7Qi7dkq0ZNEZt4ozaSQ/fFYMhOsULyVRxRQbnKz7Us=
X-Gm-Gg: ASbGncsF+NoDWak3fbTu1VSNyJDHaTC0KNAotv3y1DwchdPxXZJnjaO+n8C9QWdLLy5
	g0Ph+6ZFefwwxBvKJpqM0C3DtilC/zTyAsTQF8/vE5No6wwjPEQHXKLYVUuRRQIDZgQppwZR6Fw
	M5Dd87zLU/jNOo7JLsscNFH4vwgMtaiH5CV2lVGkPCJls6yu3LykZFHvNOUOjqcaejhPRpURO+V
	8teQA0OQCcotSeq0yEri6JRLg/mTxEw28GuyYP4S4N4WVlzxRqxoldQ0WblFJVNT9HDg5egMd4X
	ajQbUWfk95SskguPGI2Z7sfQIOUPDfbxqBAUb2UODMA26U2SiZC8ke8tXXBYtJpqYQeH/EYbPwQ
	vUJI=
X-Received: by 2002:a05:620a:448a:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7d3f98d9073mr176484785a.4.1750438639104;
        Fri, 20 Jun 2025 09:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpK+Z1a/STaxapcURqJfzeDBgLN77XcEzNViOUOIZ1OptR6KagVRbX/aeElcpv1q7LaDkYfQ==
X-Received: by 2002:a05:620a:448a:b0:7d0:aafd:fb7a with SMTP id af79cd13be357-7d3f98d9073mr176484185a.4.1750438638761;
        Fri, 20 Jun 2025 09:57:18 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b7242sm186984066b.118.2025.06.20.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 09:57:11 -0700 (PDT)
Message-ID: <d045d7c2-87c0-4f4e-a853-7a3a3c5f596e@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 18:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] power: supply: qcom_smbx: respect battery
 charge-term-current-microamp
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
 <20250619-smb2-smb5-support-v1-6-ac5dec51b6e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-6-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MttS63ae c=1 sm=1 tr=0 ts=685592ef cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=PGWYFjC4ci8_ood58tIA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AucNQEq2CMvzNrR4tIiSrUGhgWjLYJkc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExOSBTYWx0ZWRfX40jn3m1kFgho
 4Kqox8TYCic7xKZqNUivQJxG6fzfrcIn+dV01nuaCg1s9OZ7wdq6cv7Bnwu9VyA+IzWxy1Ii1hB
 VMVO5uyKGnD0vsQmefTcxrR5WybHIii+Maw2LwSEtnri1qqAgSxoCSw9qmSYVVpKlS/bpU1jFdP
 O7k66L3XWFl0mpSQRtbK//hVATbv/Wt4KjWJKwAXE4Dzyofvsp8xvXO8tbNDQCy7mPVdrBYckYv
 l+KSIrzZkurGrEELCc1iAsksrszHdmBwLWAW0kHHEkvRLOBodW+qEAZfcL590VoWda1mdKws4VV
 LlCRiMoudvlNvKLJ2qnnNUOUs4vPgyyRuOuoTV+vm/6XcieAEgUAcx1u2+cBWXXXNsMkG/oS2xN
 11DsBrZ00c5PaodAQvv3T/3L9FgjFHKC/IJH1NyMpVObcwKY0Wyr/9ggidBTiAVOcgrrgwJl
X-Proofpoint-ORIG-GUID: AucNQEq2CMvzNrR4tIiSrUGhgWjLYJkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=788 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506200119

On 6/19/25 4:55 PM, Casey Connolly wrote:
> Respect the max current limit set on the battery node, one some devices
> this is set conservatively to avoid overheating since they only have a
> single charger IC (instead of two in parallel).
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

The subject references a different, similar-sounding property

The change looks ok

Konrad
