Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F736492C
	for <linux-hardening@vger.kernel.org>; Sun,  5 Jul 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783245375; cv=none; b=lBKSWDchahFGuCPL2JWXyB0M6wznOvkIwYvJDBTNVKxX2xKzH+VidpuIIfZTZmJgTaks1gVGUwuhdD4yzC2Wkyl8ChIrrlxuLcXPWRSzpIpDVygsDQPELQkRbHO8sr24Mds5gC0C5QjKTp3gtpuEaIkiwx1Gahi8ntOeIyZk4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783245375; c=relaxed/simple;
	bh=wZydx+D7+eV35VMeFKNwwx7xhnLkiOd3Pqlp0spAh7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eubiw8GxFp9PwwerC13JSAFzMBqUaDtUUmxMlGEjQqVshikBOVblwiFokcAOd5dtBncRH/rTIAnDQl9qy591mlhzRiRF1hrwHvLONCHnol1bAofbYXKeeUxQj9k0w+WlBR/2KyV9wdNUGMm3shUWUiBVSrtCqxNIqwOKEmJy4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A9iDBty7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CJUVZ+2u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9iDBty7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CJUVZ+2u"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6652An47467616
	for <linux-hardening@vger.kernel.org>; Sun, 5 Jul 2026 09:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qez+BIm+WNGrqobZFOyyBrQ8p8mWTuln4FzUBmn1x2g=; b=A9iDBty7BwcCDgrj
	obxijsZW+M/rwRFDYVUFQHbhkEGOAnuqZKGsmTsECOmKS0FE3CMI34EozXNGIj87
	JTJ3+8Y8fSYUulkLXd1+XCs2pLHfeinK+1WNL4mFq1N2KC9kVL50y57sCRC8q4XN
	VzR61ed9eubtEoLHSR2VMDCjwx2j0NZOHGSqc5jm5ATOdLlOl2HrwbKVldezI4mN
	lVj0om/3jtfUweFUBRWNkffYepokyQLdp2LcmIAVdmu+T3uEyyn9GDe66xY8gB4L
	LWDK26qBspZoYBUizgT6+CNvsSfK4U5EaHQqzl8JtCsj++rqQSQQwEIS5l1rHwZ2
	IOnGhQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4stk7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sun, 05 Jul 2026 09:56:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c9a700dc0eso14939375ad.1
        for <linux-hardening@vger.kernel.org>; Sun, 05 Jul 2026 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783245373; x=1783850173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qez+BIm+WNGrqobZFOyyBrQ8p8mWTuln4FzUBmn1x2g=;
        b=CJUVZ+2uxVk/eg4IpVjDHAbXkmcXGPho8Z5LK95PS+7M1bDmO+OXc1pb59wqlGnmHA
         YzXYwkEM8fizoM+H5PjK2AUhrUHf+1MGdbokjCSEgHR06ubdDwHedw+7k1pC2fomp6tv
         bC4Lj9pwQWXDP9N0ywL04U6ZZc57ZV0qaSOUZFBTt580tmYsCk8pIu4GA/lUULyXjZFs
         pD7cpDeod7/b60SapBgI8WidB9QmswVqjlkzksPF88ARPd49O+5iiBDkzOSpllT30HZ6
         8Z7IYGsmGKRYaYh7ra6fKaCa9XYtR4WpDlZx3Lx9J9/1st4wBVq/ScRx6AwNvGdV5oDU
         F6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783245373; x=1783850173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qez+BIm+WNGrqobZFOyyBrQ8p8mWTuln4FzUBmn1x2g=;
        b=JizopXg60y0loeci0DMLVNk3NRm6mmfiNHgZ0QRr6vnGJdcNmNokSFpLevmC+6aJgP
         W3g4Q3LUYN7ns5W3BBWbo2OJuwi3XB/WklOMtSW6fRQUXD8lh3h4w1Q/6WjsgTqEbTFl
         qIfEs0PY/XMOTrJ8xarqHYGRzM4VpVDRDCFqCsFHhFI8Uj3+3GoDZgsoUPcfZ2sUqgwd
         APBdDdwQD6cnWappezWAbETzNLtM4UrciNR2rwgz3S0GRhZdSJXDY/poI/C+VB2iMOle
         Uojx2ryN5M1DOWE7+Q8LNytZdxFVF2f5EiKQhfGV+AbrkQ622lBwZXYU4Q7kNItixyo6
         OC7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrvO8AfNugaFBlon+DV1O9vSFXyJ0xAyStDGwtDi6z88ZJFGqtfT9jLZEZUTzeILtiKDbbCRY5A6FUBdC4/QhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhzxh6OPBDP1nFY7o6hzrUAHZ627imJChbW54ZgVvkulolHdPK
	S62q1inKVw+hkQoDaJptxJcHrcpF1yZhSSaac9Qg9nrJkPOKtOBSlxZ3UXnnRGy+1iGHO2kFemg
	24E1utNrkCfKQZUQ5VEzlwXYahSWRe6gaOuZSOqFrMPFc9xX80h6LRiKbA+hWQXMjnfHVaxw=
X-Gm-Gg: AfdE7cm6dX7CIgWzxK9OPgflgekSKDmi92/Xx3cubWVQ1ZxcYDXL2AbYpUZYQW6S+1V
	jiJYz4Bz42+T1gtXUl7U7P98rpU2BUWZOnSHZpI0JUEPcn+prx8aFKE/bGK9z23BvYmxMZaebEK
	l5SRSuMCNA5+vvypKZu0GYEc9uQAgPvT1tqCjGr5kPmG2bFpNEiWngZnn7IyBtNqDV/zcyoebO8
	1BpMLCq5HJdeRoZSPcmLnV4t2pziexmxb0pFvsSvbB4Fh3fHHWmqvUGbQWli7Bmrqt6eE6o0sDv
	XZguFfaemW/hPfhOrBXB4TtkbdMzRnBIRHG8f9v4TvQ03VFniy5/IK7kyiTJA4O0AxaToSbjlhS
	eIq8eERSqsmn7e0nY8GsJGjXhAvTFhigfm7lb6LiH3w==
X-Received: by 2002:a17:902:f78f:b0:2cc:9763:e607 with SMTP id d9443c01a7336-2cc9763eb2cmr2054015ad.27.1783245373106;
        Sun, 05 Jul 2026 02:56:13 -0700 (PDT)
X-Received: by 2002:a17:902:f78f:b0:2cc:9763:e607 with SMTP id d9443c01a7336-2cc9763eb2cmr2053695ad.27.1783245372660;
        Sun, 05 Jul 2026 02:56:12 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm60691241c88.10.2026.07.05.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 02:56:12 -0700 (PDT)
Message-ID: <6383bfc4-e193-4eaf-a44a-b9a0233068db@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 15:26:04 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] remoteproc: qcom: pas: add support for TMD
 thermal cooling devices
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-4-3882189c1f83@oss.qualcomm.com>
 <20260703-accurate-feathered-mammoth-11eaac@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260703-accurate-feathered-mammoth-11eaac@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfXxtwNIyNJM9QM
 CmNxTzllGicS9z+7+fej/ShCx00a+UWbKu+DaT9gJbEddlsad/y6lkIWiwwMR4xNf/UPOfVbvAu
 L2ixgoGnvVzHJ/TarR+1XV6C2yqulz4=
X-Proofpoint-ORIG-GUID: z_AUxMByb7ByD7_oDbK5zjweSSXxa_JS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDEwMSBTYWx0ZWRfX2JyPqHx8Etwe
 N4v3Ofb+rPfQmvNNhIEjENtE9eZbDrdN3QN7b7gqJf8CncW+rYOBXrrs1EMohMuehqH5hRl7cgC
 Sfufm2VIV5S6nJYwmbaCz7M68jHAg+o3mQ1Mw8eOqkmX2nB56HY/7xHOWwUHkob+JOr8L7WyPWF
 dQaP0nETbK4Oj5E80K+9iuAT9CUgAwzkdFmt3F4IgDeUuodyO76+vvaRinzFM3vOwbcqpNtpe1s
 m9HMWWI0K081JtmfcHo8JUPrWM5yISWXSQkEYyxLmufDBCRUF6T+ek5eBt6rYsrj+1F475XCv5s
 aeiAXmCSbjxWCoz2827jP4KxQzJud+RoJTcy7iI+3zk355Jkh1clJhQQ91JA3E9uGpDYzWfqost
 ffcLMO0qCb2jo6HPge0yL3eW5tPA2DV+yCvKq+Z3jRKy6haKoPr1RD/BzN5vcs4zLzSsWecYGyf
 Nnz3z6ihx/s1isyYIBQ==
X-Proofpoint-GUID: z_AUxMByb7ByD7_oDbK5zjweSSXxa_JS
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4a2a3d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=UwBSoYOfm8cr69mLPLIA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050101



On 7/3/2026 1:26 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 10:33:07AM +0530, Gaurav Kohli wrote:
>> +	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names, desc->num_tmd);
>> +	if (IS_ERR(tmd_inst)) {
>> +		ret = PTR_ERR(tmd_inst);
>> +		if (ret == -ENODEV)
>> +			return 0;
>> +
>> +		dev_err(pas->dev, "Failed to initialize TMD: %d\n", ret);
> 
> You already print error msg in qmi_tmd_init(), no?
> 

thanks for review, this looks redundant. will drop it.

> Is this probe path (looks like)? If so, why aren't you using
> dev_err_probe()?
> 
>> +		return ret;
>> +	}
>> +
>> +	pas->tmd_inst = tmd_inst;
>> +
>> +	return 0;
> 
> Best regards,
> Krzysztof
> 

