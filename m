Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDD3F328D
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659979; cv=none; b=W+MjGsC8rPorPtLcdPEedR8c6F2XTXw4vZEHTRx5h2cZ/UZ9R0c12u0ULWP+79CBr9lAXCjO8YUzX8vRPi5PPHf3wmqJbW2TweIzvi9GJnGYdrbDNJ7KC0KP/A3gmkfHcMbclW0jiJOox2a93yL98pLCZcx+aUOzDDR8vkPw7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659979; c=relaxed/simple;
	bh=Zy/uplELbej2l31ZzUf+KHC+qlsRNpMsRObEQAmlf2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Szw5oPCec5hlKcItrK6gS3EMoO2Y+pP4gqL5mxSZDsULK7rmilVBPmYt/XpXisIfq7QBEZ6ENCDLPwWHZvB8hEL8X8yjuGkFODSEmR1iXJHppTjWpBwdnxNf1l1CgNTBf05x+iAL0/E7W6kS3bryoDqqQBWA4AY0Cp+nR5m4K0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=STOUkQyJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BRrv3QaN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="STOUkQyJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRrv3QaN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAutMW1152797
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 12:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GFYBfDMFLN7EfoYr1yKrbGv2vHYSkMdELyDJzYvM8Ig=; b=STOUkQyJC7MwAcPo
	Lbed1T5mcuXzoWZ/nuwaFsLC6jSrjPmBAWI6RJh8b7LtXeUfHOhZRtsXfQxf9Vqp
	KCQNJJ1FKLH9Eq0r4aRYaAjEztgCNCPhurViedD2PdncOZeug+uuCiuBLlw1VUVH
	t1C/yMCkhhJVUPN8CkycbQvVo4tfB7wjqggy2VFEDxKNvB53bsInutWnIykI4G6l
	h+N/Sb+lc1ubOSbSrz7SeulJL61RzM9eRNMaX9i5rMxhcUIafUFJzw73JXVJUWf3
	MJh4L5jgK64xm9wNlWGMNkigYGmk6dmc7dofB1ZwJaPCAMRKzCqMvJeKwIMurqZ1
	BJjszQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93nastn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 12:12:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so60784005ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787659976; x=1788264776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFYBfDMFLN7EfoYr1yKrbGv2vHYSkMdELyDJzYvM8Ig=;
        b=BRrv3QaNeTjSo87ZDwyB5xp2VVjoiWYSLVb9cbx5nFH7E91zKSqMGZYR17cbrBSlVt
         QwVWmUGu+24nxdkXvk5kcHOzwKx+QOHXkdAMmDFWKiE+eeNpE6wehyYxvWMjm9ydNUqW
         c5wo5nv7t/rLLiHHGcy1/CFRRpRIk2PZ9MyI0UNA2YKb2HA1d6T7ZaO7mwL3ZpuW5Iu8
         OC+yUuY8S6WbjKQoKmcERkHJpCYefBem5oQOT/LdbT/w0QtB830ItWnBM67tt2p3G1f2
         wSStJd+DB/nF6/G7xZvcetQ5x/j2wSZVnVYgGOMv0PJ60SvLrOyeHn5QhJGjVl05/xNu
         1nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787659976; x=1788264776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFYBfDMFLN7EfoYr1yKrbGv2vHYSkMdELyDJzYvM8Ig=;
        b=IzuwPNAWTRniqc+2NVXOiLbygPd1vRJykucroyD128XeCnROMDiPRCnKbt+k/o9THK
         XzFLelK71vwRQ33qF2gWx3QPksFNAUQ63INL0hL6fRH4A3FE+No4lv4HR6af7cURAGko
         aCD3CCfJrEXLL2oCGDRX8wS23SIetOckD0q9uxaHLZU/t8WpapPYvL2OMICJg5fG6BFc
         hkHlPYzwRxG8hUl1xH+LDVOsHU2vdhZF9jNt2fq9AapxPyWU1Xo9TfQRaXagzWNsIMky
         Og7nKmmaZXThd+3OOticgfX8x1Jqs63EfS/hYzENhWHxtvnUJYwx6J7ExQDwaGTu+6yL
         vlcA==
X-Forwarded-Encrypted: i=1; AHgh+RojBVGWn6E/1ML7S99jPecJ7l9Khq+OOksDxBdBMfOdUEhhYcX6gypTGwfedKLPm+VulZ9WIuHeOjj9y+WzHdU=@vger.kernel.org
X-Gm-Message-State: AFuF++m5aKDNZa3nftUHi7KdhcaUZVrTdeDmEL+ZmOJcmt9Np4t21nU5
	s84Q1nvzP5nYPVny9orFB8WSSijNcfnrXH97oJ85p3WHuV/IP3YNyqMbIvLi+QHdjeJSkTVrGpC
	7DdeHANCtq1pdN96kYXiP7l9VXqRZO009ekKEwkSPA1eqdNPJrGOSLRq8Csn014t4Wo716qA=
X-Gm-Gg: AR+sD13m958x0F6swr1FGEwdi2bb8IKgvSyKeSRJ0hnc0bEpoCxzlFdy7DyYGcy3sJo
	FlexkT5rxE/CI8R9wMPYQ0Fm1XrEx1hD3qhSLw0AblZoXleT1suYAA3j9A0gokeLBB7ZAbRT5jg
	7ZjmTTLWxlRShmbGSVyi7Tkxs29WJq658kpuNaftDmCWa+VWUuzWZYRwmOcHSVmYBEZRWIP5UPT
	V6loZQWZWC0AHaB7grpjKxRucHGItR2/LmBKmo4i5WW1sCSV9biLVtOv9UvikDf3EFz/jlGrd4b
	+osmR/aIBJ4nQExmoGgo1rpCSp847buzImJT02QzVIDp5uFrAdOMpyQAYneU3R0kAVrvkz5byj/
	Aza2j9wGIJ2RKNmlWn7VLXx46fsFOS44=
X-Received: by 2002:a17:902:fd8c:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d64addb782mr652487135ad.6.1787659975989;
        Tue, 25 Aug 2026 05:12:55 -0700 (PDT)
X-Received: by 2002:a17:902:fd8c:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d64addb782mr652486155ad.6.1787659975506;
        Tue, 25 Aug 2026 05:12:55 -0700 (PDT)
Received: from [192.168.1.16] ([106.222.229.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768d9241sm28068785ad.71.2026.08.25.05.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:12:55 -0700 (PDT)
Message-ID: <c9964dab-d396-497d-bb67-5e509fc8a085@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 17:42:47 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: talos: Enable CDSP cooling
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-7-b15d47adc379@oss.qualcomm.com>
 <b471a134-397a-4f0a-9d79-1777ed067c54@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <b471a134-397a-4f0a-9d79-1777ed067c54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwMyBTYWx0ZWRfXzYvSHJiBnjeu
 Qe380RqrjHHWTFv3MYRrMMnL4EXbLqYCKqv5nNJCvAWQO/kLhqSOfapCcVot7Tx5LGykov6oxlg
 JaxcYwCeA7rCVcPuwuTb7SpmVAyEVxo=
X-Proofpoint-ORIG-GUID: LBDPlloOdNz1lm4OymF8nGJuD49EgTNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwMyBTYWx0ZWRfX7WZz4/yqKXb3
 dylINLKvjc1mBEVHLJasxWIAga17k647+pdEIPNIqtAUqj9FEDot3C6f7veYHmYr4Ai5+9QWpQy
 pgEjzsKZd5XRSjALlS8nTleVgeosLN2lKocTqE866pzrwEoYG35Tt4QQabGQQJOaEe+VCBxu87h
 lQ7OkmEHPhuWEaS3b5t/8ums2hwhsx3UqxktNXOVDsxJ+kZcztuX1BBPZzzmx71mcXcmf02eRH1
 vfR6r/ELUbKEgsyPPE384Dvj5qm9J2fL/PcW3z1x41cYBK4hnCHUqlbkKInDbPZx7ZYOt4oGYf2
 Bp8XFrdSgIdTmNpuAoXas6/YVy/dA+QGCZmG4/b3nNeuFBOXcFAVjFGTk6eQj38PSQhnL40wVo6
 pfxhKOrAZ1vssgwvfS55SKAmcIqzviAOrWIFD/fko+URMXQ1UwqYDtqRdBXUKCplFcvwgYaGchd
 wVViq9mI4+s2Kx6JShA==
X-Proofpoint-GUID: LBDPlloOdNz1lm4OymF8nGJuD49EgTNy
X-Authority-Analysis: v=2.4 cv=W74IkxWk c=1 sm=1 tr=0 ts=6a8d86c8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=x3UvaR+l8cLCJ1uKBUlNag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KkITgS1P2qNXoWSfFRAA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250103



On 8/24/2026 7:47 PM, Konrad Dybcio wrote:
> On 8/9/26 2:29 PM, Gaurav Kohli wrote:
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in talos.
> 
> [...]
> 
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&q6_hvx_alert0>;
>> +					cooling-device = <&remoteproc_cdsp QCOM_TMD_CDSP_SW
>> +							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>>   		};
>>   
>>   		mdm-core-thermal {
> 
> Should this sensor also be bound to the rproc?

Thanks for the review, Konrad.

Talos does not have a modem remoteproc device defined in the DTS, looks
like modem support is not present/disable for this target.

> 
> Konrad

