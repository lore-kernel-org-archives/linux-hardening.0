Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9013318B88
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768041961; cv=none; b=ZajIp1f85Le554PdyB5VKW7jAk67Hrmk7Fc8orupJWRFnmI+mJxPsFq8Hx2Hcny921qewaaskV/1Wy6tNWiB45RRyOVn6rqLqyDberXNru8DAm9NZWqe/ZYCPYCjCdPWcB+Udb8kcIwZl5rSBYDFKpYB1B9d7NLTCpzaCpmPNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768041961; c=relaxed/simple;
	bh=TCNHkGRPrNl4tMA9s5UCLLKzeAgKmFTcBT7iLjFJLos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4q4aqOdymVGFCTwV2f/me4BMotBrTlSAcWO20HBOOHfMqcOaiu2UzpZ4aLCdJcfvE+JSNrl6UqhlAFPoJJXZ8QT3VhrQdm2MaB+nF/p/P6KOLobzdCpxjLwYb9jKzQEejWr3vNEj37isdsXDrWgEHLpuS3FacQHGxXFXyUYuXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGWMeufR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PHODIxQa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGWMeufR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PHODIxQa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60A6fd2F3481647
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 10:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dYQJmxLtA6YlVQI11wziCwTn
	+OgvteNvmNWULyo3Ies=; b=dGWMeufRm4yyPfvTyTzGV+kIfLckaUM9vLN7tZh3
	wHVwDOZsxMK+Pxdh12nnInNl+Lt3SSmccoeMtZz7XSNm/1ss/z1qryPA6szdZeLe
	1HOQeUrf3EKEIF76ukVtOg+U+dRpjX5h5TuLN9sMozZjG+KEZY051HcqJQXqeKs9
	8n1hQM1240sGCO0SULZ86kTsNAl/CPv+JVJTJ0i7/tqxtuw6yjQmFKaReWG4jiOP
	kCUyLyonVVVO6w0ogN46xVT/poR05brmY+jHrNNSioWuVMJThjplWaJ87Mf1Qj34
	11R/E7I3U1oNsgIeKJOWEYczRb97ft3ZB2v2/hZgV5HxEA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkeusgj33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 10:45:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c1cffa1f2dso1051568085a.1
        for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768041958; x=1768646758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYQJmxLtA6YlVQI11wziCwTn+OgvteNvmNWULyo3Ies=;
        b=PHODIxQacTvcokNZaDYckydttnj/TqzrRUjMjtBKKS1jDGpj/9dLTGlYtUn5IJACY8
         reGSqAYQBO48Q2TBEwZBCujjH/KCMt45IbcQJxJS9ZpPGnKMzZKzbBL2U3KtqsSUmt9i
         toQ+CQpBB0yMLGfEzSe49fvy9Zsn893TFddoRdAv6AAbZjWKInGOHR01G9MAcYCfjWYe
         aqUpeBS1P0VtmjVhC3aXEy3YSWtZn/MrCMG/Bvi1N1Nv+136UDaCrBtlmUMsxffytgaL
         KsJu5sIgOEi97kI44HidzJV7bX3lrKBp7kwqUSQRsfTsri0KbmRg3Tl3q6j/Q3q+GZOC
         9RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768041958; x=1768646758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYQJmxLtA6YlVQI11wziCwTn+OgvteNvmNWULyo3Ies=;
        b=Lt0x5tn2VEUeJ25Sa3QhO7N7S/SkeLbnGezgRy01Dci9KP18EJZeKdL20V90ztFX1o
         YXlNcKPcOMjbj2f9AxvzsOe7P95xKiQdY9ZHhFG249OzMh8frAZQqYhEOY6ICpC9maDp
         3S23YJERL1FsyrGP5uWM5hrtttIcN0gdJvNLBno6lMAEQOJqwoOhJFMUwwe0+BODHV2B
         BbfGEEPJmKuhvpInOpMgOnYuMpXc/DL6GKvvZzoddLRcq5eoeSgJFLOrjzNbSRZNyDJi
         0aIiL+bcDVG75I9FeK2puRigMM1R8LojfboCBe5S7b9Y07xih/2bEm14M4I0BjFATUFO
         Jxzw==
X-Forwarded-Encrypted: i=1; AJvYcCUbCgoGvRi0ioBAfEg0JOHP81FQwHoimDULdekSQY/cyaaPn1fRYO1aIc+kD0yRRt3lXV87MPKEM9g+0SmRFko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69ZQ3wrlO50t9xf0BdL3u3JF435rRyJLds64sik87fRSPPOFk
	lRl2/6pxn/mWuaCTnrTsrKNy2niDExHQN2gv3VR9oHzriFfuXjKNjzHefQHL69eKl8Jri+uqZO3
	dWqSkChy1CKHLMmoXiiBxg6/jjnsjqnKTIf8ZS3gRAR/xI8xZ+w56jMsi60JtJakXp9cNaS0=
X-Gm-Gg: AY/fxX6HHfEdUAfmZrTUVUqzGto7jD6o8dxowzydGTl0kZMRh4kCtKtHbj1Lf+c7eWF
	wsh5dHdPHBCw5IRF9oR+s0ZtwRHXkrcSDSsR/l/fokp+8mIEtEG/iuO1W0mHTViAg7JZYxe1X3r
	PNvolXvmBTdzs2B/uk1kifLVHc2fH4h5Y7mS4ulZHBzUihApbE2JHG8ZJwd+70gu4/h5kw9CHx9
	O0+OWaiFjoV+vgZe5JgsmePAq1wvTGXu/qBzVUsur6iUElxUF76kkBP6HwnRem3FxbYnUNzjU3w
	Z/TBxYtGC+oHnk0gwPt41ybFw0SJUcFcWygT6/Is5+3CO8pHmE+SpCh2s+mHScV4xLyk/4v2JG9
	rsVqo7SJ1piQzIl6SO63QikGYPzaNWwPmD3+Mt8Xk6zTuopw23OZjO16w8ZJEf033lGOwLa9yCz
	gEioV1a3b0NJP1gGVtsr0QnZI=
X-Received: by 2002:a05:620a:44c6:b0:8b2:dd78:9288 with SMTP id af79cd13be357-8c37f4d6fc3mr2194443085a.13.1768041957797;
        Sat, 10 Jan 2026 02:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQEsXHEtrN4Tbqm72kgYTDVw1nykFc9S+KxE6Bnu6jdH0gUp/tS6qLlXb4fD0qTZS54Q94mA==
X-Received: by 2002:a05:620a:44c6:b0:8b2:dd78:9288 with SMTP id af79cd13be357-8c37f4d6fc3mr2194440185a.13.1768041957303;
        Sat, 10 Jan 2026 02:45:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6e821fbfsm2697924e87.35.2026.01.10.02.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 02:45:56 -0800 (PST)
Date: Sat, 10 Jan 2026 12:45:54 +0200
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
Message-ID: <nhgxvv5bm3bevq4qkqnew6gaqlwiaicrs7yjckg26fgwnffqj5@u2phabfukljx>
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <20260108-topic-smem_dramc-v3-2-6b64df58a017@oss.qualcomm.com>
 <you4xijwc5g4ngcnhxm4ecn7opexnsdfayvd5wiiqpl7734r7w@bdkpjqmlzxre>
 <b2pqfrs2ptaoxxeanzumxyibmydsoiqslcsg6yrm4hihynowj4@mzazqnrptnyf>
 <hunbpvbfkcxzbnwr676z6fncgdhfumjedx7jp5izojusg3rj7f@5te77lmqcdaa>
 <cleh7dolqus3grexqfchtavvnj6wef6rlslgv3r7gesfuyxhs5@5b6z5gwtn36b>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cleh7dolqus3grexqfchtavvnj6wef6rlslgv3r7gesfuyxhs5@5b6z5gwtn36b>
X-Proofpoint-ORIG-GUID: wB_UkIBs8fJI6R2ID0f3IG8fH7pC7jiB
X-Authority-Analysis: v=2.4 cv=GNMF0+NK c=1 sm=1 tr=0 ts=69622de6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KLUUaQERiW0IIiXZ-soA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: wB_UkIBs8fJI6R2ID0f3IG8fH7pC7jiB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDA5MCBTYWx0ZWRfXzv+vmjwIJ2Ex
 kR5Wd+z1zQLiybS3ieHgIXwyx5XHG4jh1JhlNB3VlLKbCHB1BR2mC6lLylA4t4IBNcZma+ELFaR
 ZxR/H6nG7ZttJjhypoi4xpig6UPn4aJYdqZb248DI66Tgm+vBSFnv/nxLutfkhNAnYgjChb+tgC
 mPh6urzbhYtP/MQxlt2gxNh4fFs6nWwfX0Sn4reCUKJFe5EnRnSvMpdfhwbj0+qfXHh0hmt+s81
 xGwfKNsgutyOr00Mej+O34LmZbUrG7yMAquOlG9ILwkb5OMmv3LwUHHjF90oW/gDB48ctKoRYSt
 VBtTaviwt9ClidSeZzyRntN3LdB1hWy/S0lIGGPJwH7iVe2e+2ANSoi2p0zWinnT1Yq9JU8smd0
 T8LMWGDdW4u/vYMLO/GCiSsceVGUnM2WZdJGWD9Y1LBA29EaGLfe3fDriXSmZPOjzcbndzs+EiX
 pCbWdry3FknLET6Lfvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601100090

On Fri, Jan 09, 2026 at 11:50:46AM -0600, Bjorn Andersson wrote:
> On Fri, Jan 09, 2026 at 05:21:10AM +0200, Dmitry Baryshkov wrote:
> > On Thu, Jan 08, 2026 at 11:49:54AM -0600, Bjorn Andersson wrote:
> > > On Thu, Jan 08, 2026 at 04:45:49PM +0200, Dmitry Baryshkov wrote:
> > > > On Thu, Jan 08, 2026 at 03:21:51PM +0100, Konrad Dybcio wrote:
> > > > > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > > > 
> > > > > To make sure the correct settings for a given DRAM configuration get
> > > > > applied, attempt to retrieve that data from SMEM (which happens to be
> > > > > what the BSP kernel does, albeit with through convoluted means of the
> > > > > bootloader altering the DT with this data).
> > > > > 
> > > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > > > 
> > > > > ---
> > > > > I'm not sure about this approach - perhaps a global variable storing
> > > > > the selected config, which would then be non-const would be better?
> > > > 
> > > > I'd prefer if const data was const, split HBB to a separate API.
> > > > 
> > > 
> > > I agree, but I'd prefer to avoid a separate API for it.
> > > 
> > > Instead I'd like to either return the struct by value (after updating
> > > the hbb), but we then loose the ability to return errors, or by changing
> > > the signature to:
> > > 
> > > int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)
> > > 
> > > This costs us an additional 16 bytes in each client (as the pointer is
> > > replaced with the data), but I think it's a cleaner API.
> > 
> > What about:
> > 
> > const struct qcom_ubwc_cfg_data qcom_ubwc_config_get_data(u32 *hbb)
> > 
> > I really want to keep the data as const and, as important, use it as a
> > const pointer.
> > 
> 
> I guess the question is what are you actually trying to achive; my goal
> was to keep the base data constant, but I'm guessing that you also want
> to retain the "const" classifier in the client's context struct (e.g.
> the "mdss" member in struct dpu_kms)
> 
> If we're returning the data by value, there's no way for you to mark
> it as "const" in the calling code's context object (as by definition you
> shouldn't be able to change the value after initializing the object).

And I, of course, misssed one star:

const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(u32 *hbb)

This leaks the knowledge that HBB is slightly different kind of property
than the rest of UBWC data.

> 
> You also can't return the data by value and then track it by reference -
> as that value lives on the stack. This has the benefit of making the
> lifecycle of that object clear (it lives in each client) - but perhaps
> not a goal of ours... 
> 
> How come the ubwc config is const but the hbb isn't?
> 
> 
> If we want both the per-target data to remain const and data in the
> client's context to be carrying the const qualifier, the one solution I
> can see is:
> 
> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> {
>         const struct qcom_ubwc_cfg_data *data;
>         static struct qcom_ubwc_cfg_data cfg;
>         int hbb;
> 
>         ...
> 
>         data = of_machine_get_match_data(qcom_ubwc_configs);
>         ...
> 
>         hbb = qcom_smem_dram_get_hbb();
> 	...
> 
>         cfg = *data;
>         cfg.highest_bank_bit = hbb;
> 
>         return &cfg;
> }
> 
> But we'd need to deal with the race in cfg assignment...

static struct qcom_ubwc_cfg_data *cfg;
static DEFINE_MUTEX(cfg_mutex);
const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
{
        const struct qcom_ubwc_cfg_data *data;
        int hbb;

	guard(mutex)(&cfg_mutex);

	if (cfg)
		return cfg;

        data = of_machine_get_match_data(qcom_ubwc_configs);
	if (!data)
		return ERR_PTR(-ENOMEM);

        hbb = qcom_smem_dram_get_hbb();
	if (hbb = -ENODATA)
		hbb = 15; /* I think it was default */
	else if (hbb < 0)
		return ERR_PTR(hbb);

        cfg = kmemdup(data, sizeof(*data), GFP_KERNEL);
	if (!cfg)
		return ERR_PTR(-ENOMEM);

        cfg->highest_bank_bit = hbb;

	return cfg;
}

This potentially leaks sizeof(*data) memory if the module gets removed.
Granted that all users also use qcom_ubwc_config_get_data() symbol, it
should be safe to kfree(cfg) on module removal.

-- 
With best wishes
Dmitry
