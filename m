Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036F1E7660
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905936; cv=none; b=hYW9yEoDZ+0grebZ3I5XBypcDAUm3AKeZJphbErLFgOJbaTpvPbKzQoRp0lnOmJ3Y99i8l9yhJR2m6wa2olHZTfQhlI6SbzXb8mXqSG0eB2YA2YdGOcX+iQJfcjlODENS00s0OmWLQABpVvSkw7RR9wIFPZxMA3WI2h0MxbUM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905936; c=relaxed/simple;
	bh=81TJmYsISJzw2vkYd3W+a9qNHSCY7ZfteqgWjZKnJy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4BZ6amCc3ZX4eN8rBhjCQnF4LfWgOEUcvd9F+RVD2Vc8sVc7auIW04eZnZCBbpcI4VWEznmA/uRWcqUCjzjICgprGPGlYJyFls0Vu6rQLdize/WYZVQ48a4CTonwXXWpO04sELutkl26+ux01ytg4gYLdwnXMwUwycLX05Fm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCRRUHKZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KSalKh8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCRRUHKZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSalKh8o"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O3KrRV2442143
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 04:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C4fvuYxVjNpUmJ0ryko/nP3p8aeV4LlMrsvq7BoATTg=; b=VCRRUHKZyEj7g2Ei
	o1jvMPoTyrzmXILs4k2jjAWaKDlXMNhXetJsHOd6NgfO5Q5NFc1VscLgsk7Aqw4+
	1UajcLaIXaPD3Pq4AQm/vqcdBaD+58lv6LYAFB9sMorLNRMdK6nbr6j7NeB0MnY8
	GV/zYWBsvykHROsJ1I1fiA/g8N+gytAF2eM/KRJdYTheEunZsHl3Z8EMQNt+GSOf
	mjbV9m08EDPgopYSeU+9zry6kHn5ffBmRSxZ8+VuomAtglB5jwEIkwMyEyisil11
	+7iCh24mheFK8U2qva3Ijc+nvp9y0TrBcx7LaHvUbnfuM6YEczI/0xvYA7tzwoHP
	FlRtVA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y2tv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 04:05:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70ab7f67fso3640067385a.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Feb 2026 20:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771905934; x=1772510734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4fvuYxVjNpUmJ0ryko/nP3p8aeV4LlMrsvq7BoATTg=;
        b=KSalKh8oqpxErTv2UX2QoPbw/09z/O/n+TH9qcqKk3636Oro0fAcKTSokKRTnNuB2l
         03wGUhXUvJGmmMzR0M9yD7pXua8u6vSEnYuwrssQdYSgmmk+dTVuEjfjeWfXz/kB2Xl1
         tlPbWZqTIQlXTmeu4YB0MPygnZYZE91CDpMEf84Ob2IkVrUtF52IYCgi3hcgcFAgUAxj
         qLM3uvjQetwUDW7s4pclSA4/GnYdiCao5FMHeRSqM4ul5lB7yFV9OjWyPGSfT2/T2suZ
         NH/Y1C3kJhD4LQO5K2VFvaHChm52yo5FGzCYLd/3PX8jF8IbUxnzXRkdQmO+BrE0AbEO
         Y2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771905934; x=1772510734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C4fvuYxVjNpUmJ0ryko/nP3p8aeV4LlMrsvq7BoATTg=;
        b=waJd1J0HcULc7iQa7vFk8an+heWuYGyo9cBYB9eVin640ou3RufIbYpdxIoIrCQYY5
         UTHS3yXHcJXtqSTNQlsAJ+mKGmzEq/Vq1JgEiZGOhZN1Wf1wArxwm9V2jNTt/Fx/5Fnk
         51C7+61AE6zhpSkcpbjKqMVpPiUN/5xU/YOFNzfyHxeZpM8sUG6JaST7Smd11pX1qOpg
         iJ/v0g53tec1m0T5Rfw4wnk9l60AXOmN4l/nrPROHVPbk3vRzQnzyCHEqqttpZNOA2sw
         7IK6+Pqw3Ofc01LIa/PXcqaPab2ErQ9/L8loxoqtX2UCiXMGYEBQZBfmTGHvzHxacyqL
         JXIg==
X-Forwarded-Encrypted: i=1; AJvYcCUx7UYBQgI8TMFQ9hXglN0XjdVYKe0XzGtz9Zd0f+xgwtluZfzo9j3gyw8sASoX+Yg9X1h/MfT4Wp7NRWxuFLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhl3ZJHDnqG5M5tk+SFwyIORnMV8fsbGbmvKn2Z+q5AASkDGc+
	ZP54njKhdtyZrlPmi+OIgM7Mw0tWu2Ux1K8N8ZSSgIZ2liLDcB35DCaT85BsEOMfWUR9RbnlWkl
	BuVFkq1O24x9mKPfBDw6HFv1mU04C29wZyNsdUrIxx4ulGznmDoafteRQjWfwCNO/cUOJDmI=
X-Gm-Gg: AZuq6aJjwNDp6nOba7SlKZnzROUdpQLBDdqGje61xMwjyKihWFedo1woTAR4ase/vWh
	6wQV8eN7f6sdWh1+gs744pqDZng9u6IY9fhy5thdbp/TUl9uBEdN8XUTOYNdNBJRRhnimLtEkIm
	gu1NLusKttlu3Brl+SQske19rgMykCoEFlzmifpvkB1e26Q1EFBbw/50SsqiR1RMvGMNVEokHuY
	Zbw+2L7MY3poxuslubWzeAxAdgESI3ywxe82Hj0pWTFBVTEf/UG8pGpqhLSiEg7Cw/gGAbg3SHJ
	iwzX8esvXoOeKBdjnNfsNBDcWKwVdn/39DjQb3hUjG2JM6/iUWaE6XcW07uevULlG23IrNwBrfY
	RyhZ7+rNyJZdP2/F0NTcoi7pm1yGBIoQobf/BJUBfc46g5pZtrXZm2WsUsjKycMaU1TptiNiAND
	9dp8c7urTpj/xtCpnzOnJpLklBbSabDAGPOs0=
X-Received: by 2002:a05:620a:c53:b0:8cb:72b2:2a14 with SMTP id af79cd13be357-8cb8c9dfda9mr1415440085a.16.1771905933641;
        Mon, 23 Feb 2026 20:05:33 -0800 (PST)
X-Received: by 2002:a05:620a:c53:b0:8cb:72b2:2a14 with SMTP id af79cd13be357-8cb8c9dfda9mr1415437785a.16.1771905933106;
        Mon, 23 Feb 2026 20:05:33 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb4c530sm1913135e87.83.2026.02.23.20.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 20:05:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Kees Cook <kees@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Adjust msm_iommu_pagetable_prealloc_allocate() allocation type
Date: Tue, 24 Feb 2026 06:05:25 +0200
Message-ID: <177190591481.429979.14151274658881021527.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206222151.work.016-kees@kernel.org>
References: <20260206222151.work.016-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAzMSBTYWx0ZWRfX81TUURMetFIq
 EvpZzVi6jXFqg6f57zlzsHuz+DRnrUvZ8EtPdjymREtl7ZVhJ5iYPzSLXcxiBGbQ6Hh8jqZ4Jtr
 t9I5IPrS6da9TasP0cywf/qAZeB8Y+1SbYY1DU8o9DDZo/xdcLGZScuNUHZo5LbBtuy7mkxsJlY
 uyCAnBecsK7S7rUjppWoOwiJZYjQZ263VsHk8Th/kw/j4rQZLpVE8hP94zm1gocDgdndTUISFGG
 7dq6kQnwj9gdm0kTFt1FjaRZFuRC3MQzvy6AZiXyHgEHLeTdyHaVCy2a5Fm0Dp0+qFBkVAlGCK0
 Jzs01fLgxDIULsmjXXECsAbT6AT/7MtmaNACWD0QoKTOAaefJ+GEBpGa8++zKWT0xukzzKaeIYJ
 MR22qStDfEkdrZ2NJWrC9liHIVpDgg+lv/g0054uGMAeKjGRk9H6zTXy5u9n+nhZCPTRVhMcyEQ
 Xrxbw7qEwWgPq76MBiQ==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699d238e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=HIUXOl7pohhbnBzAbCMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: oH8az2NIsQLCg_Dc5Uyooyo3WQRq1_Jb
X-Proofpoint-ORIG-GUID: oH8az2NIsQLCg_Dc5Uyooyo3WQRq1_Jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240031

On Fri, 06 Feb 2026 14:21:52 -0800, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "void **" but the returned type will be "void ***".
> These are the same allocation size (pointer size), but the types do not
> match. Adjust the allocation type to match the assignment.
> 
> [...]

Applied to msm-fixes, thanks!

[1/1] drm/msm: Adjust msm_iommu_pagetable_prealloc_allocate() allocation type
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6f6f3535192d

Best regards,
-- 
With best wishes
Dmitry


