Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F33AC5A3
	for <linux-hardening@vger.kernel.org>; Mon,  5 May 2025 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487144; cv=none; b=mMNmE/1tSMt2gdUAepBKWOflzVczhLn/JFWqHBGmFfZaYEDnAm6qTz4dXatN6Nnj0QyJpbKZPN43MmYA9sdVEe19qPufnUfFXhZ/ViHThr4ejyiw0svpLBUJ91jGhE0v5aL5F4c8xJaXjEMkAvzaHRHJaeo+3RRY28ZL9THj08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487144; c=relaxed/simple;
	bh=szSy1DusHGWtdc5DBdNxGyYxoEy8zsXq36nE02dq3Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tATVukQQhMBxy114N5tCcxwQr4/dC5B/AWdPYQTvWrs4Axl+im9ZQkAxu/dllZOXZuHQEWMwEdAfNKrDB4k/pIbwpipwCib+5q0WPpSuTfzR22dDM4lMfXvpWs6w00j0lF9Dk/F0ZNeRn5MJW112kZG4W4dDwQfyLwkvwqGBGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oy84eHsy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oy84eHsy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545KTZsp007915
	for <linux-hardening@vger.kernel.org>; Mon, 5 May 2025 23:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	egliTNxrRWezR2u6nVEeNELYig/MxmMlQ01oFG+bL58=; b=oy84eHsyzw4cIS4t
	IbPIQBGACmEjACW5IsGawddvbVqI3FFn1seYPXHPptK9aK0cX84nidWwqwuonHVD
	yMve+Sosb0N8+Kfh2UNdHWK86ZhqRJj6oV9VqndrIEsP3x/GNOmkWWnAPMNzuH/M
	AL8M9xwo2k9cIRvghPBeEu7PVTNlMQxSfEwWTiNI2bCxvMvpwNuQPvNOvlYEyd/5
	cGSBjVDx1pdRIbUsQdwNKnTg5KCFk/BNC2V88A+4EvHfFb1QPy/4vEBaG/gFNYjz
	Bjm5J54h3/Jf3v/q59zx4SzPLVXtb9msx0BQ+irCq8F0p31wiIOXflDDOiJR/kDL
	D9rRGA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46d9ep5nus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 05 May 2025 23:19:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22c31b55ac6so70048145ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 May 2025 16:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746487139; x=1747091939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egliTNxrRWezR2u6nVEeNELYig/MxmMlQ01oFG+bL58=;
        b=U3CyFUIu46hdLmVWLCAesoVYt1EbHB693H3UxsVyK+q1YWZ5YSpQl5Ah/ofidMduPJ
         UIwMUIjjq58y9bBzEZpwkma+fE2GykJZuSrRkxhNSCjmhaXeTqXeh1FNJEa5jgnrwuUG
         VQ2awJPcyd/TH5t5PIosar7KDU9GA9KDXWPFS+/hrjJD5AcSpufkTw/G01HZnk+AIGTA
         Cgk+bnm/dY2TSFUoyvBnvzyACabd8kvSuBTMqUd6DtvD/MAe08bELKbSn+nwP2zES+e/
         /j3Rpt17Y4jo3RIKbT1sg/lS4XsrgFa/Q+ImIGLn6zdymVgluvNjSgihbVl4CE1mCxj8
         s3og==
X-Forwarded-Encrypted: i=1; AJvYcCVYCg0kNV4RHhPWjcJIrtS01iM9jmhG3tFhgHl/61+pmYipvGikItjN9XRmZvYHNFWJol1LbxIOdLfePgGn7BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6AFbNyuJLbQRuF9MkJQza2RrEb2r6iH0VKl1cwsAnNDDEZ67Z
	M/IeVk/wB+SRGHyaGEfxb8GkgG3IV0HkptpxZR3SsR+YTzVeyv+GP3KcXYhdJtpTtHxjCceNLSV
	Rb8/I34vnmPR4kR6W71qb5cEYpsI8Mr1V5vFnUt+Kwkd2yTCey0stUiRvpa16xi/mrA==
X-Gm-Gg: ASbGncsb2hLkIfm6dIN9hd7zkPmuqf4Wb9ZNrBJ/czDmBcWuQmhAjBV1M8NQ7vGDL7n
	PPT5gfZrq0MpHzMSmWp058eL3rX9U/syj8FE8wEHj/7ls/hVQhNsRFu+0p3zQXdkLIfysm8Pro/
	Y69TicTG9jNwjBopQ22kjjv8sPKAb4tqlC+ZWrH9Eb+c4IAuLPuOCsYt+vm2vqUTJ3FOVf8aJav
	UpGdxSEHhB9XeZ1Xt3mpDcHMIqVsBOkTGMTSX+r7f+c+08xZctf9ANFlOmYqkulToiAtgmYrQh9
	VDvp2FTgU7gMI1npPhBQpEOFct9EABAXS4H0iKukWht5a2CyQt1oh0jPxm0aOScUDfeVbOvpHcv
	UzMMVSafK9g==
X-Received: by 2002:a17:903:11ce:b0:215:a179:14ca with SMTP id d9443c01a7336-22e35fa48edmr11374145ad.2.1746487138868;
        Mon, 05 May 2025 16:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdqr8QmR5hHl03YHuIdiZ5XDPvQLzJ8NRfBgcXvm6h4rkFqPZiU9iHtAyIKS5UBK5d6Ay3DA==
X-Received: by 2002:a17:903:11ce:b0:215:a179:14ca with SMTP id d9443c01a7336-22e35fa48edmr11373785ad.2.1746487138404;
        Mon, 05 May 2025 16:18:58 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fb3esm60612335ad.121.2025.05.05.16.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 16:18:57 -0700 (PDT)
Message-ID: <2a0df02a-1657-4b59-8f31-791a8aff523e@oss.qualcomm.com>
Date: Tue, 6 May 2025 09:18:49 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] firmware: qcom: scm: remove unused arguments to
 the shm_brige
To: Kuldeep Singh <quic_kuldsing@quicinc.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org
References: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com>
 <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-6-6a143640a6cb@oss.qualcomm.com>
 <246da659-2add-4ccf-b914-f737fb93f3f2@quicinc.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <246da659-2add-4ccf-b914-f737fb93f3f2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=68194764 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=S5yCOARCkap2nlZrFcEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: pzwkVFeMaDMxygNppekAZy9HktW4aFaB
X-Proofpoint-GUID: pzwkVFeMaDMxygNppekAZy9HktW4aFaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDIyMCBTYWx0ZWRfX439sYm8M59Er
 LPHWbo14eTJd7PGMkSoO+cmdVFJiFwVny+BjZSaClzYbi1D/s6ASrqIj+DKiKfdpOsVxyWXvPV5
 6w3r/b+/q/u0zlSkZkkJ0c7dbIwveEr+W+mLqmTonpIUqDhk/1P5J12HBPTdI9ao9lS6fzX2kF0
 nkWr8P+gfFkZ9L248V8adNBWgY2vP7wrWKHBjtmScgPwnbSEymFEBd8FQ0mHJ4S/QQ3eHf4ugqJ
 uBOl0Gl8+RMB3p1/MorBynWVAJQ9ANloS0Ln2TfAVj5wTfoDbDxKeYzZXEHsoqTonSXQwwl6bOJ
 rAue/DpEVbUau/Kjw+hDBN3a/Jogp0GmOVx8J8c7qA4IT/QF1Tlo3zmaJ8+wd258fdiDt+/lurJ
 CLBnDVpEmgc4EWevOnIn9wqC/ZpK/eiHla9O0Ty+Z6Ys3RzcV8DGY7APB1oPS2KMygGlkdSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_10,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050220



On 5/5/2025 8:58 PM, Kuldeep Singh wrote:
> 
> 
> On 4/29/2025 11:36 AM, Amirreza Zarrabi wrote:
>> shm_bridge create/delete functions always use the scm device.
>> There is no need to pass it as an argument.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> 
> There are 2 type of APIs exposed by tzmem driver for pool creation.
> devm_qcom_tzmem_pool_new and qcom_tzmem_pool_new.
> 
> Device managed pool is created with devm_qcom_tzmem_pool_new but
> currently qcom_scm is using it's own dev to create/delete bridge which
> is problamatic here.
> 
> https://elixir.bootlin.com/linux/v6.14.5/source/drivers/firmware/qcom/qcom_scm.c#L1653
> 
> If pool is device managed, same dev should be used in qcom_scm to
> create/delete bridge rather than using qcom_scm dev.
> The dev passed as an argument to function should be used instead of
> __scm->dev.
> https://elixir.bootlin.com/linux/v6.14.5/source/drivers/firmware/qcom/qcom_scm.c#L1634
> 
> To summarize, I believe correct solution should be to pass corresponding
> dev to bridge create/delete APIs instead of always assuming to be
> qcom_scm dev for devm_qcom_tzmem_pool_new scenarios.
> For qcom_tzmem_pool_new, qcom_scm/qcom_tzmem_dev can be used.
> 
> Bartosz/Amirreza, please share your thoughts as well.
> 

It is not true.
Why should shmbridge need to have access to random devices, while the resources
are obtained from the scm device, if any?

- Amir
