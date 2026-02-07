Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148117A2F0
	for <linux-hardening@vger.kernel.org>; Sat,  7 Feb 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770455598; cv=none; b=JZdAvjskgtMOPAPM+v0PsN85jtpi3XQ2GV2Y6Zs8ktGVKpOx8biZl+sBrFsLYS/Dkp2j42rmZry4ouf7rqxgkY3UTONaTaMefI2DotKZU8pjCsaSVSHGVVJfxI2DzkT+G0mLCfdKOZ5T+HzrnujpSs2apWQXQnuBDvcqThc8iz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770455598; c=relaxed/simple;
	bh=VlUPWMAqypEdpJZi2GWeQiiRkpy6zBBiZPD0Xd+59qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSLJDMcrLGFOdD0xbYSqR/bPmmiK8HEUposzmVY8qeGca1L7aRvHJOYwhSMWRlQ6XgEusiKAjKzDrXQPSXgxngkC95N0aA+SuXWtja1H0wId+WJsutpfJfscCJRJI5ykbNTM4LuGdAeOFI0hWTu14XqHO7vD0HDCe/IucL4/p6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pb5Yoqmw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SwmrYbRj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pb5Yoqmw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwmrYbRj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6174Nqid1628508
	for <linux-hardening@vger.kernel.org>; Sat, 7 Feb 2026 09:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZnhPfRcyvXmJuJSiZfwzyHe7
	jzBv7YRscb6FfNKJ8LI=; b=pb5YoqmwIkiTWV4BTcm1MMbKPi8Nhj8aVVJ9cG0V
	76vEeGsPWhJQvNxzHJ8PWKegr7VI+D3ohps176Htydpl7W7TIpa6xyJuwzx77CKv
	7lnMXr+R44bt00GQQDerJ6tRzTxjKffxtBjdfvazdUICpCLw/lmUx+i/1ZbFBHBN
	SbPYC+3vvn2mIanSL520174D1KMTlY6eWyOP8BvojNVLWmLI2A9V7Y8RQy+Mh5ly
	A35LSKrwrNt2j7/oKzG/S8CON1vrgh2BEasO410oXbLnL2+rkOSK113dj+8wQpnz
	1OgG7trhbL4JNF077BfOwHlDF6vf9/RYVwJ4hWnIUF0QcQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xb50dt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 07 Feb 2026 09:13:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-894971e3b60so86035106d6.2
        for <linux-hardening@vger.kernel.org>; Sat, 07 Feb 2026 01:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770455596; x=1771060396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnhPfRcyvXmJuJSiZfwzyHe7jzBv7YRscb6FfNKJ8LI=;
        b=SwmrYbRjqDRtHIQFtFQQYZLImPs6CIl7BNLaWuEMQWlW2FEWKJGzkwIfleAMDlus3T
         FttRt+ZPCrkszACDoGtjKuzsPkW2gwTNiedcIXrqPDgqCJhFs86GhbsUGchInbl5NWK6
         +1u9x36Irb+XZlRXFrrPrpw6W83xUvbHCrqKv13ZoJH9zzGbYz5AnDeEjbaCeM0fC2RF
         pi8UgbSB1mOyGJOsQEJTmHM4MmdEkne7k5nPYH1x6Z1v5FevgF9ye3MQke+WDRSoIsq4
         VcVhwiKbbJ3oOzpsFEKd9ROkNV1k0yZWywp2+nAHIpz2uDa6GmEOk/snulBM+CQftLjz
         dCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770455596; x=1771060396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnhPfRcyvXmJuJSiZfwzyHe7jzBv7YRscb6FfNKJ8LI=;
        b=r4vOKhZeM0udBaxrus2NoQPCbqUQrfiiu+GP3iXrQ5+ZdB4XvdQPi0CF53ul2qI4pF
         FCDiu651Uu7CwyXbDmnS1cmPthi/2FaxIf+tyZRnCInBLhD9X6RSRO/HNxHbKCm8HBBs
         lYbBHuzVCHspN9xitOARgThHYsMDEM8IkD3DjHHBZRYz8oM3ic8EvJZAJtTu6AK4YroK
         rFuJwC+ioR6wCveBgJ+va5hUGfW18mPyAQvS7jlTi6UfWxCegU6uKgH+k3CmMg40InwI
         7D96i0ogvLqbiBrq5WLfOA4UOvnSn/prL/AI6ENHvDANLFrf1zwCu7CP3KHpwta2H+Us
         y9vw==
X-Forwarded-Encrypted: i=1; AJvYcCWbNrjG36Hz0aH41L6dLlSRiasKha+W0yHbgRKDIvsY8/scwq1S1zmg3AvIUrM0sepX4ERJ7kHH5xFs3zxsLmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBBruq+CMP3KmDRKMmNEuG2avlLQR2PCqpxyVeTtYv/5b2sD0
	dsY9r6b7fsOCP4Vx1Q1YHZa5DA5MZw8cL0p7C/5/3QIUEzP2y+cz+qYM/OEoFE74kfAL44E2XAF
	RJFUGI1rTUV1lXVdZHYhaG4DnQLrZ2v7AYHcPrdvebFKkknMiFl/IiTsd2r3fuVzd7cRkQ8A=
X-Gm-Gg: AZuq6aKEsqFAqC1RnqvZHCsv+ot+ZX0nXUD5nkYxv6phQHQmgHZ8KC/1tYE7gIEVRsu
	+iX+c7sYngP5qiaNWilXTPgDWj/B2vMFGR9L4xs+wZ5Yu5RfiETKdJCOObLnMOIfCsrJj6qGRwB
	1XaSUbRfgZ7wPHx8ycopiad3W+5rdDnbfkqn/otqOosqpb18+nsr/bmVkZsdy6jyGmcccys1KUf
	UX277g/vvW/kBxAvWX6/5LtntgAUyZkaA748/wqnImYU+r6AJI6n2hRGniI0iNals1VnwcirZeE
	fNuVb38mFneRO9ExEoUFue6Er/KGsiINwlWM8o3AMGVhA3L9z8Y1yBCEtVStjWAc9Rsnm8uZUSh
	RZY+rSU180ZEY/cK12UHLkwz+8zfnsLtpAxJLyroU/z3eEgJQQ8DZQFu5abmjELTYjGGihJYbyT
	62TUjXuxl22XBciWsJYE2TEyc=
X-Received: by 2002:ad4:5dc2:0:b0:896:17e6:b3d7 with SMTP id 6a1803df08f44-89617e6b59dmr1404016d6.68.1770455596333;
        Sat, 07 Feb 2026 01:13:16 -0800 (PST)
X-Received: by 2002:ad4:5dc2:0:b0:896:17e6:b3d7 with SMTP id 6a1803df08f44-89617e6b59dmr1403876d6.68.1770455595931;
        Sat, 07 Feb 2026 01:13:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b63adc3fsm10918031fa.26.2026.02.07.01.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:13:13 -0800 (PST)
Date: Sat, 7 Feb 2026 11:13:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kees Cook <kees@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Adjust msm_iommu_pagetable_prealloc_allocate()
 allocation type
Message-ID: <734wzdoihl2qn4lu4inig5taw5n2aovabpce5y27qb5kiftnwh@ynnugouvaran>
References: <20260206222151.work.016-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206222151.work.016-kees@kernel.org>
X-Authority-Analysis: v=2.4 cv=QMBlhwLL c=1 sm=1 tr=0 ts=6987022d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=e5mUnYsNAAAA:8
 a=parfbKQTulTwLggSwN0A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: FAE3yC_zsu7gBtCCwk3ldY9-LiJV44Fy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDA3MSBTYWx0ZWRfXxgzGy5RkHH6M
 /3l9ATALijumarqzIplSEOU1mYAcHBkHquGb1TyFRrxemONIdv5+s7R5z7gIoRFB3F4f71t7n13
 eMOyHsHVIEHY5BxUoHvmSaPgl9ePWt4IpXU+oK9ZtQHTDt/nW546TH5e9uRi9WHq4fBa/HwM8VO
 BkeXwRK8XfvjcU4jvLNlPaKsD8G8E8ny1UmPjxqzjVVtJ0FJCGBLsXB3wORKdbO2hVKseG4BCvt
 xjIfl5u9HzoJYKjgz71mmPukktzl8AYkRJN05RzN2AIy9yN08IKgteISIcnruOcLS1soGTQQExR
 M8Zqd6io4fg3J4DFBT25wvP91Pqp6T8fWZPr3sttC+rlci0fPDNtxiuWmlTDYD7p4klufxKS24B
 QG0hC3zeDC3PEKrh3wFOgn3fWyNyIknzJivOhvncQTrtfgvWdZ4HYbDtlmFiV98ei3aH1TE38MR
 nH2uPfFsDg1KyoPAWiA==
X-Proofpoint-ORIG-GUID: FAE3yC_zsu7gBtCCwk3ldY9-LiJV44Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602070071

On Fri, Feb 06, 2026 at 02:21:52PM -0800, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "void **" but the returned type will be "void ***".
> These are the same allocation size (pointer size), but the types do not
> match. Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: <freedreno@lists.freedesktop.org>
> ---
>  drivers/gpu/drm/msm/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
