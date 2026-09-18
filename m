Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D64A2A43
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718552; cv=none; b=i0gOSr+rbONMb3e+0bDuJYowzETGNok38ITnW2QMJVK8cifDKn6u4ezD+cqvnC6iU2LBcxXLA0MzeTnKOc6kzohDx+3LjOgt3nNR2Y0mx0nEHdiZMk8CKv8fIx8KGB1ZAGZuKix10hGLrrqEILXs+4RNw2mGqXNG/kB03M7AGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718552; c=relaxed/simple;
	bh=H0JBUe/EMO1jDRgyP3JDlGDtcpO2ZiZNH1bkYAtEw5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRG1uMRdbRuP3VoWYOSIRgrfi345ya1fWAaZmKPX9O+WYtaZdtjKpIcoXrsa+H0T6AfzYaj8wZ6YDV7yScXbBw/VEucirc8DeBRtCRPCp+NOsmyhJh9LNepz3pY9vh+Fmo8TjKBRX7cKJtgjeuwTf7cPFkbHIIsXPtzklbyjM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EulsZUwO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q6+rbisc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EulsZUwO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6+rbisc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xpH6910693
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yecFht45A3Z4564vTTjcaZ4Yfxl5AMB1C6lm2vKtsvI=; b=EulsZUwOr1HtmugT
	76JcKklLlxafRkkNiGxkvh1QFsZqImpSCTtX5RbOGBnwErhP2+/jaJylUWMQO1zV
	vw3+Qfz7sjeq5KewahfVEVw9X63m7sZSwHE8ULsI9AuQEPigcwut6kEseF3mJops
	4pBYeVIfyr+3Ucw7klbyFp4yQNDI6Kh75M+rXxP33x96nQFebyH5Eqj9XQGFM5pO
	Kwi2bJz4WiMwgRYAOQtniAFUlQ4bUVZ5ozjTThagXEH51uGmdpsD3rJuR9yEhZHh
	eVoTmUACezDeOuIt5UC+GI8A3mXlJZgP2KQL9wfKlXhb++gmMb3zhGJz2AlH6SgW
	N4Sygg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grtdpsm4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 08:02:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53002215979so1239891cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789718548; x=1790323348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yecFht45A3Z4564vTTjcaZ4Yfxl5AMB1C6lm2vKtsvI=;
        b=Q6+rbiscp9z9VLTZ6/uHLpINecuFm4VQ4P3suDYIF2EUHc9bJsWbMVDqQeS/4uS0aG
         Ei/fQSlytOJhxizp5NZZrvRaY9IzeCrvwJI4rv7Udpy2J5KvOSix/YCS0fwtenczcOMi
         eYK+haC9ea+tjAhq1mw8emKjm4eZ6AdzMgUlp2tV0LzDAEPm0nkjy5ctyrtEj+upylUD
         bmcV2mYwRPvZcxG+93MuJ48ld3htQiBCTbRndDoPsaHe+rjKUcUpPRCjvBuu9uwFJALF
         1V0oG390BhWOxK8uqVKfqdwvK5nh6AYb5vnPsoPRctJFS4Xk/IKBFPGFQbDPZJH2Q+Tu
         FjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789718548; x=1790323348;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yecFht45A3Z4564vTTjcaZ4Yfxl5AMB1C6lm2vKtsvI=;
        b=FDrpJgq6y92bitmof34L1hmLIw+ByN3XvULDWvp1s3s+bR4HMf0F0Lj0IUFZGY7hTr
         v+nfc7PUac1xqyxOZMJFkgQxhD0jMNbXQUDAlKfJa/ijWpGm3yQh3NkY7YbpGETDHAzw
         tmqXt5G5gndHzvcxIBSoxbAERMoCYC1Ivazqm+IUpbzQTC62UIgCYKhsxVTSmiyoJyJD
         lROGz5K3dYvmSiVJZ9pwTyj05LorUnXvFNQr/PtGk2aaFdwre9Kz+RFKW4T851bRkCri
         YyhrrYKRjfDu4dfKuVYXKZKrbQVeFC4jRwD7PM1Pxg/pUBUZF3kZkTbu5UuAzrzpdW6k
         21Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxdYHlFOudYqNEwvfdisULLk4oDkhlvZ4ExIKM4MxZ0JeVTt1ZGqjJNAhBoO0mbPFu3W8jXlyKkgVFlAd1Xp9k=@vger.kernel.org
X-Gm-Message-State: AFuF++kGlH0WJmOkCvmz1tCpS/5LJMMExfpgYtVAVrv2KSUTgCTOBsdZ
	NRwGdrvhq9KgcbZvYMmLu0DSfw6XLBs6OfsEpBtA2p8n1W63rjz30PraYY9goPBYu2Ajml4i8lO
	1zvDZPXwfRgbEUqtV3nmkdOs6YiNGfozs48XuHCF1HKZcIE6fASXvT0+661SO1p/ElfSGtXg=
X-Gm-Gg: AYBFou0g6qxUoqObKG9aL+jqd5KClWFE7mzsad60iom3c/3DaxWHf926xxvMqLNEa9Q
	FZ1eEGKBn9N+j/3169//pSdz4Jtvp3sS/XUGbxtNmpb8VXg1Sf6nTdkQSS5hSCRGUQGVUZw/5jU
	iILr1rszx6zxOVF8yxf1hw5MUMx0T7egNAlwRNV15hvKza9KATEtToZdb/tL/X6b/iVzKJkgMKk
	rsGSfhF5QWabYrapqpCt+lUx3e0VFHVNNSjv+kX76QNkoDm2Vl0SjhQ0uGq/zq8PgbtHyp5Xsoy
	LArgBHz858V9A97Rspm5jpPGZbJ6Stb9MwJ4KiHFh/Cekwj3nYLgsLkPOvN56MoSYr6a/4eZQzk
	sLX+F2chNxGXs6AuJN4qe4g==
X-Received: by 2002:a05:6214:e8d:b0:912:16fd:b389 with SMTP id 6a1803df08f44-912570aade9mr19737496d6.5.1789718548092;
        Fri, 18 Sep 2026 01:02:28 -0700 (PDT)
X-Received: by 2002:a05:6214:e8d:b0:912:16fd:b389 with SMTP id 6a1803df08f44-912570aade9mr19736916d6.5.1789718547676;
        Fri, 18 Sep 2026 01:02:27 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa5975d070sm505624a12.23.2026.09.18.01.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:02:26 -0700 (PDT)
Message-ID: <be0e4cf6-f16e-4dbb-a5e4-85760c20f37d@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_smbx: Remove const from desc
 allocation type
To: Kees Cook <kees@kernel.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: Kees Cook <kees+treewide@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260917211309.i.765-kees@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260917211309.i.765-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX8mKZGaT1wJIY
 xjxaRNLjvLxjzqd9Fho2xTPXhth+U04z/+bSjdkxPeWOljHRj+680YBBP0eVc9Eny9hoCJufUEp
 hk5ROoHMDGkbg1/Mrbq4j6p/BEsPHAe2FBLoKmHBQNYUs3zCU3eUgSC0LDI3XeNJpjd4MM6ujM+
 IlFmyVnn1fhwQkFbidMTtIlS3YurwrlTt/1Duqrq6F2cjO2USCmocZdWenvkWMRYsIGzo7YHPeT
 WLZ8U3m6yDQZ2IPKpdUEEbC8Ild6uBlNoYgVrHaf1n/XExM5vWxc9T8Mi1K3zwgidwKIhrl0ua5
 rxpjlZSFy6Xu7044ZBLsda5VgMkNKqVor/4I3c1He1abs6HjDPX+8v7hgdLYa5bkpUrHPlpo0uC
 A2YY2DSKXESUaTpKa72ZRg6piiAg72CxG2Kvi52lhzBWbG+6GKBX+/bzvDzB9KCSW6W2qBhZRSX
 lo26o+n8OOVUAF4SGqA==
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6aacf015 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SE4sDywN97dQNR5h7vgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX6V9Ykl2drzNn
 aYAZKdEYglyilW68grDfoMQ3QJwrPM583vd/0p9rkj2xtbvdtAEmnlkHwMREtCWKFj3dWIUddSU
 jSI2h2bMGdUeLg6UQDt0/RFeze5xOdQ=
X-Proofpoint-ORIG-GUID: HO4_DzI2Wk0e-wenKsnStc7uXxVFYeo5
X-Proofpoint-GUID: HO4_DzI2Wk0e-wenKsnStc7uXxVFYeo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180109

On 9/17/26 11:13 PM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "struct power_supply_desc *", but the converted
> allocation type would be "const struct power_supply_desc *", as the size
> was taken from "smb_psy_desc", which is a
> "static const struct power_supply_desc". As there is no general way to
> remove const qualifiers, take the size from the assignment target
> instead. No change in allocation size results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> drivers/power/supply/qcom_smbx.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
