Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A41E1E04
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928877; cv=none; b=mEisisa4lxda2/Iv8fdcqOPOHIC/ZOGib5z6AYLVrGbwF1CJDKz1prLzGBqr2BDx1joJb3XrY2lZqD5hT1gnBnY+9He5al+Ex+ltd6pwQRV5CCpp9ThplI/0X0o606zRm03xDl71nUuGIdkMqpMd0TfI4qPF/yxhnBn8W2fCEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928877; c=relaxed/simple;
	bh=j6Ov/jIMdNgGFmIFUkaffg950FgxqH7B2zkvQewFdz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je6Q/MKhy3rL7Z1jSrpAoCJXxY5XhjNXHpN0u1FCxMIIEVuOmq7rrFNLK5idtkTbQe2905EXpOkmGAureHc0wBeGMjwWJt21r1HvKkuA2asnk0tR4CDKzIfdXZMJW7yavdhpNAXguQbVc4D3MWWAnltSTJfTim4sN2wAOfuRqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFQgQyQQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QiBgYH6I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFQgQyQQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QiBgYH6I"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608Nr6mc3729572
	for <linux-hardening@vger.kernel.org>; Fri, 9 Jan 2026 03:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=l0S9oVoW17ZH7EHn9m++kxRL
	IL6UaU+sg4ZdoxU8wC8=; b=jFQgQyQQCec7pV7N38Bwd7g6+2p6h2fEE+scdPJ8
	/RH7R7HnMag3gKilpUHxoUL+zcO2AgI2HPOflOVc1DbesViVs/jgPOMZ7szOHkz1
	Wa41X2JNfK4ikoTD4p3lbEKF8tMUQG2sTHRjzl/pXoasPrjWdZjjPFN/0Vu3oGZ/
	v4yk95aLoKCbWhQ6r6ugYSw2tdsk058R4TyX1iqbD5DsMrRnpjGK/z/YMgRx7VUk
	++q75AloMQPrr+lZ4KaWIKxfGqD2uyx5mKallexTQlKjRoSapmCRnxJEQN+MesvU
	pjavZRh2F3JWa4zSi9/G9NS1EfROa8aBQfhx+WfP0XSV1g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkgf4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 03:21:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bc4493d315so920949885a.1
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 19:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767928874; x=1768533674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0S9oVoW17ZH7EHn9m++kxRLIL6UaU+sg4ZdoxU8wC8=;
        b=QiBgYH6I4PsyM4Xmelcvbi89s8pQlb7PLn6H6Bdeku9Y9WkofZ06WBlOuBzW1j8DOl
         wZJzXMoCqJ4KUeSsHCb4t1GAiEPliz7eWojcy9JA59MXSsjVg+w15zvbjvPsjpw72T5O
         W7uo7Cngl0doUSMUsulMjo/qpOHhae5+SIFZgMusW7BmSxfCv+WwvILJjqzn6D8D3euH
         zj6nWwk8rMLbYVzuaOkNLmLGPt7ogGrZkkiBcYYdGAd6ySXt/fZoGzJBrJcf3QOl/OJs
         4RvlyUT/NYdJJHcka8AYFYkF16ygjKhSKBY4qTMiDdYhUyvM2FrHuo55sNRw8JHjnS2A
         RT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767928874; x=1768533674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0S9oVoW17ZH7EHn9m++kxRLIL6UaU+sg4ZdoxU8wC8=;
        b=eF/sO9scl4DpZmzMPrfQlgAOvMZNvkDTZ3abfmpEGRiaTeE6ZuOUTceHR/fqmFY9KA
         N6aI6kO9T9thgWGpCplTkujWk1YkQLeyOpaX0kCmZE+/cq82+0LZqo2QUitnhX5JLIfI
         5A0Bzeaa1O9JdBRbvIZHYvILv7wT+1/OjrJDI6D7ukzr7xioKqElSRgVKWThlglMBhoK
         JOWkVGA7wSU9LbM99I5H8b0ZnUFtyNhrmBvm1yxGtj3tEoMpYRdm1ElCYBoB+bR7a+Gx
         xJgSihZ032diIM24x2WZeAoGBi+aDE2eXoc6tetaxT4s+zIpTJ4UWjqDXatrNeADIshd
         +Gdg==
X-Forwarded-Encrypted: i=1; AJvYcCWH+uJ1ZKY9okpgInVt7cDvNkz/MPYcDcdofeJNu/pwr/6DmH4wZMbE00T3pbOryEZnL6o8lbJrRmNt8E94yqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaRmGwCFl9/hsiq569eLF4h65gDZHLV1j8EnqFgPeaiS1v9Ko
	ZWAsLs+bQcX2LHHemxaApI1Ey42Br3nud5l62Lrrt9d2xIAXZA9F3Ca4GqK1o1piRX7zuigSKmh
	Hj18E8bl1W2rETrqbEb9GE0DudVkw3dx/Zg6Y915aHOmqZRYV7c5ue/iZ0PkFwyuENoU5eF0=
X-Gm-Gg: AY/fxX5OSfCZUZwRFqLIYR6tw8/fsikB6oJETkYiHVFbCR3v7JdJ8pMahGCT1U7BR47
	UoISMbRTo+TvJb8oF8/MbFCaeukomRe1MTfF1zl4hef97Ho0mO50772t6xMouFxudCpvYDAyFHP
	CmcDxw3d9YUDeltmY35FE7Ktmlh4/lh7lcYfyCL7q7a9w4T7O3o1+rVaMXgJXMpjs4xtMvl773D
	Dkj0kVMn9wbtBTPr0ZdGtRBA3bMrZfDD0yOWcKd298acsGv3Oma8gh4eTG4CqRKvHcTsl/rUc02
	fxUEBFVMFbw836I7YKSd7WZ64Bz20OrmY+qms4zYqKI15UqYfyqCQztDoNGBak3En33jpNH41G8
	38We0QSsicpRAk4pBpWe0KhCgy1dSNiiCLao/frhyFGBV4xkuEWbcbdPClT7jCjV6lGuyOzjqaW
	HTOh275P6UsD2vTCIKjlyWmts=
X-Received: by 2002:a05:620a:269a:b0:8a4:6ac1:aeb with SMTP id af79cd13be357-8c38940dd62mr1175659685a.74.1767928874411;
        Thu, 08 Jan 2026 19:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7544jDNijz3Oqai5ryzQM1LZ2uw6kV2IuP26zDDOOLBfIgypo+Dzcw8kzTONbK6QX+Jn/2w==
X-Received: by 2002:a05:620a:269a:b0:8a4:6ac1:aeb with SMTP id af79cd13be357-8c38940dd62mr1175657085a.74.1767928873942;
        Thu, 08 Jan 2026 19:21:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb7a5c1dsm20225721fa.16.2026.01.08.19.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:21:13 -0800 (PST)
Date: Fri, 9 Jan 2026 05:21:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] soc: qcom: ubwc: Get HBB from SMEM
Message-ID: <hunbpvbfkcxzbnwr676z6fncgdhfumjedx7jp5izojusg3rj7f@5te77lmqcdaa>
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <20260108-topic-smem_dramc-v3-2-6b64df58a017@oss.qualcomm.com>
 <you4xijwc5g4ngcnhxm4ecn7opexnsdfayvd5wiiqpl7734r7w@bdkpjqmlzxre>
 <b2pqfrs2ptaoxxeanzumxyibmydsoiqslcsg6yrm4hihynowj4@mzazqnrptnyf>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2pqfrs2ptaoxxeanzumxyibmydsoiqslcsg6yrm4hihynowj4@mzazqnrptnyf>
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=6960742b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZmktGZHw0soJo7N84tMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gwO9iYRWzIDTJX3ws8oYx9Xsx6UZT9DO
X-Proofpoint-ORIG-GUID: gwO9iYRWzIDTJX3ws8oYx9Xsx6UZT9DO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAyMSBTYWx0ZWRfX7/JFKcYevLvM
 kZpr8++9axMdHzrBeFG+kOQCKMOqppW/fgaEYkryEwQOVPzdHA8uChx8Di12089tuX5QlytomUa
 AJQOy7SPHPlVLoNl+xnPUQYsWKFkoZmLyWQadVN6UAZB6zEcsvE2MfEvIsVSDg44aDAbHLVVh2q
 8qZWd4OCMCgZVkdupusbjvbqYAKj3n/6Q2abz0nLyiLxipT33VzJXRDjaiXlHJOtDLcDaF1KS7t
 8nJ2CJxlJzodmHdRtMyR5LcxyOwS4Ewn4tC9sPVMld42Ym86rpmLT3v554FnoqPuyyxdU3VhJsF
 K2C/+5PlMHmjcAJZfv050jQRbYmi6I6lD6CzQe+6hpN/qkq1oZD1O/ksmA+IIoISC7GDYzUnycc
 4ft5PKyZRbXh6gI6llj6+C6TZJK8LsBbiI9dNajy48t0oMe7Odw9N4fUQjJv/8O5Y/bukkUoLc0
 3oNubWIVevUg+v3wicw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090021

On Thu, Jan 08, 2026 at 11:49:54AM -0600, Bjorn Andersson wrote:
> On Thu, Jan 08, 2026 at 04:45:49PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Jan 08, 2026 at 03:21:51PM +0100, Konrad Dybcio wrote:
> > > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > 
> > > To make sure the correct settings for a given DRAM configuration get
> > > applied, attempt to retrieve that data from SMEM (which happens to be
> > > what the BSP kernel does, albeit with through convoluted means of the
> > > bootloader altering the DT with this data).
> > > 
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > 
> > > ---
> > > I'm not sure about this approach - perhaps a global variable storing
> > > the selected config, which would then be non-const would be better?
> > 
> > I'd prefer if const data was const, split HBB to a separate API.
> > 
> 
> I agree, but I'd prefer to avoid a separate API for it.
> 
> Instead I'd like to either return the struct by value (after updating
> the hbb), but we then loose the ability to return errors, or by changing
> the signature to:
> 
> int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)
> 
> This costs us an additional 16 bytes in each client (as the pointer is
> replaced with the data), but I think it's a cleaner API.

What about:

const struct qcom_ubwc_cfg_data qcom_ubwc_config_get_data(u32 *hbb)

I really want to keep the data as const and, as important, use it as a
const pointer.

> 
> Regards,
> Bjorn

-- 
With best wishes
Dmitry
