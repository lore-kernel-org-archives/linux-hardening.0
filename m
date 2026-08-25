Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B674266A0
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660718; cv=none; b=SKuaQo6MEViz0puWZVnWVNbQoManTUBCP+OKQ9bXWf3utC9UsPNfpX82NZMZsCLVLBDv3O5zVLpYt5SN86WfkRE7IeAwhASf0xtiksq5NTw9dyr7hB1P5eRauOc/FkbTIKjeHrPOIWknQLrrcsV7LtyDK9kAyfGLuSdoND+whJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660718; c=relaxed/simple;
	bh=JpvP2FsKNOLwyzEV35Oy7RuDzh4oUbBOacuQEwMmnbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMWkg9LJog+Jk+iDwyvcPlDErcxFVByScd05cKyAFO+6KmY4YIRiOoRJfLtCAJAk/TJMe9Eu67IDRBhD1QE9BIKWFt5n8d42e/8BWC86bJOhHaAqOUGUozEgGcDMZ4nu0l8+NMmRiuXxFJpKzJIwkIwsxOWLgz6wlEFdkBk7YkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JKGA+KsV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bDO76iKi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKGA+KsV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDO76iKi"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAv8Y71761571
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 12:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxvYHaduN6TNCEf+tZMW4tMw4ZUU9VGjbq8UEfNnSPw=; b=JKGA+KsVLsBLyuvw
	xVq7fI4ge6xMju05qBRPExADjgpuVwDLbXTXFPEtaYaajwe6c1ZHgkhSFeJaMNY9
	Ju052pqAkgFZ31gdzFjlFfjgNBXHL8OYV/r765siaLeUnLE4JPk23+/ARmDYMa9x
	XyUWZFzt2CJHoV6EvjW4D4L9RREnzTHnLQmAdnRCXSEJpwZ7iISQPEqs+AlWZLpJ
	oc6XP+uHUCgngzpLKqzKmwzAXzqnc5IOzheGpsSddWKZor0+TEWc/5bGv0GDn1EH
	YF/JPAlC6My1LxuyAExsenqNkDwUTFvjOTbC6JcvBEX9fCikEyFKGeT4HT/uXnT6
	yptwJQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g96absa0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 12:25:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63c16fc5bso58125675ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787660714; x=1788265514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxvYHaduN6TNCEf+tZMW4tMw4ZUU9VGjbq8UEfNnSPw=;
        b=bDO76iKioX3lqGxCWSUCWSszaVJYfScGH8eO6GwdL7dL0+cSTRcdeT5FySRYEd8pIr
         JGIst0FsyujKMw8VXcqX8e8iIpHJVEaHAI52R2Mcws+2JPM5PWlrPGMwRO76CJ26aYW8
         KptNwWPnETmhFdCUEC7eCtq+DxnSr7csN1kZsYaFQf+NjcWu7WvMF8hIBOppaVTkdT5O
         7oz4Zrhongh0/MLbzQlMuOfUky/oEKDhg8JT8avbZqhhtht0k4pBiO+D/7yeIWPd+oW4
         CnMyyYRqxMMMNYLf886TixjdWzQ29xgFgrw3dPNlhHiU+5JuF+BDVTnO+8MJJ8sK9jBK
         4Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660714; x=1788265514;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxvYHaduN6TNCEf+tZMW4tMw4ZUU9VGjbq8UEfNnSPw=;
        b=M+Vbt9SkieL/VhvsoTW/Na18nc8qkGScSsDoM6Y21toggHsTfo8PHZEoPFV639wW5B
         uhjN5JNT+7qdel9NTZuGNucwqllC6077kYfqLH1f9AoZczQNL68P12eWU/SvPpA72BbB
         LKt4XzTx5kE/4pcB3VEHa2CLsAb8rV/cNQ8T1OVpM2FGRp8fzlizEq6pZG9lhDh3sPt2
         ZLOKn/CIld/0lcLVFpP6aphdUVWS8I7sW2KSorOdTcdH1q2kbn8yTjooPL8+X1h3ptrN
         r/O5fqiLF/sBBkCl2vfWIbU3fxbKDPBXxfJvkvVbciEhCf19rL5vdRexq/xUTsnH0u8X
         WXeg==
X-Forwarded-Encrypted: i=1; AHgh+RprGKy9stmVZrd2Vi6LV8E7xiUQvxMR0ZNSt5FnOfVDUFyDwFojWD6JPeltedKhbE5OlTNTfadRfkL1OtqvU8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nMkD+VVpgXzhlWyFxFotVMtB3RNkWgJ3MyBDgwqSZlMCvtB2bk
	Y2YypNYL6brJBRJFExWpLY14pRQaI5XpOM5ffjrMW1KxSaPtTy/hgUwxwOhyoGlcEMCSgz6HVWd
	xpxIt3eFrAnUGvnacaBMVgRE/0+fppTlhgPNz2zDsgiSDoNm8IqomheuQEm1kZHui018FWMU=
X-Gm-Gg: AR+sD10ugU9il2VkIIGJTIuJ+RTkMzSM1FlC5f3Ue6RZpzluc/0ttFHM4rxoeOcOdye
	PSkHGjnUwSSsNTAO1kUExUtxfWZIXQlcGHrfEDhiM7ocu68DYKcdQ4D1Sy8qQpgHe6oBmueGD2K
	OotilvNFExGI8dFnJrjJ7H7Gb7fNL2fgwAneFs40+CeNTBjp0TwGteLjs4ZhzSoCZQ3l9lIfruL
	KefsWmF6Rmr/wRLc/V92MO6vygJDjN+90pconBfPjsgHUisXl0EQuW08706RIRIMLgSfNsMkhd2
	S4DDJrMq16dRyxyPcCQPO8J2Ga5R7nJHpxRWSHHy0AWXqBxTmtZov25fifuKAVeogv66SMYzlrq
	F0u+5NYlwADmV/cf9kLo+grt19Rv/scA=
X-Received: by 2002:a17:902:ce8c:b0:2d6:2901:6265 with SMTP id d9443c01a7336-2d6dcaddacfmr124084685ad.2.1787660714326;
        Tue, 25 Aug 2026 05:25:14 -0700 (PDT)
X-Received: by 2002:a17:902:ce8c:b0:2d6:2901:6265 with SMTP id d9443c01a7336-2d6dcaddacfmr124083815ad.2.1787660713917;
        Tue, 25 Aug 2026 05:25:13 -0700 (PDT)
Received: from [192.168.1.16] ([106.222.229.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768ba291sm27562625ad.64.2026.08.25.05.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:25:13 -0700 (PDT)
Message-ID: <ff0c8c22-bd37-451f-80bb-35389ba162c6@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 17:55:05 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
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
 <20260809-b4-qmi-tmd-v8-8-b15d47adc379@oss.qualcomm.com>
 <01cd0d90-2908-42cb-9ae8-29828d4c03a0@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <01cd0d90-2908-42cb-9ae8-29828d4c03a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfX7mFHyUO8jyaZ
 sZfnp1CBzISo3AdxgWLi3rMub8ESALIkcFUbbDCuafr3550nwUa7SkGa9JV8g2Vaw+Pc/9HmCve
 rCdL/Gw5hc6oaLhivf0fjp3SttekA0V7dEjbsQJnY5WaaknDhM6HPk3mV3DBthxdAk3tjJ+Sv9e
 A3IVpd6CNMckc5dDnsHKXOI86YAHYdxpBtSf6W3tP6cE0tWgi/NpJd0ySZtjkrNry3vDHN9q62u
 Pe7z/GWkoT5WkyOuKTDAdxZkUaWHH/4T6FQMUUdbeZ43mVm291FOKgMfJ92IZH+X8a7NvDi+xu4
 Yj/ZVj2Efp0LOSSlNaekf/JqIk5uQdEf2TrhrCXUEgzzf+s5yM86n49JmgVlWVSxtAgDls5dITL
 F70Sx2kSVfdZldG26isVTRhHPD8wA+emZbLaT6voCwblhq0b1SFviCiGHB5rasCnXc4taRhUc00
 NOmLtVgTuDhGm4qMEZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfXy9AQki7RIjDs
 W2BW5KU/1IVrbycCIJaOHf/MVecq7VEzKs2k4Fb4l2DIUpHy++JMXL0dLYwtvD8nzCocdESmlWM
 tgW2dq7DfIeOy/dU1VrHqQv4ozBuIoY=
X-Proofpoint-GUID: ftDfSQxxGsXG_ChHSci0AeW9aHMPBwoT
X-Proofpoint-ORIG-GUID: ftDfSQxxGsXG_ChHSci0AeW9aHMPBwoT
X-Authority-Analysis: v=2.4 cv=SaHHsPRu c=1 sm=1 tr=0 ts=6a8d89ab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=x3UvaR+l8cLCJ1uKBUlNag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ctB7yVnqyLGUopViubUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250105



On 8/24/2026 7:49 PM, Konrad Dybcio wrote:
> On 8/9/26 2:29 PM, Gaurav Kohli wrote:
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in monaco.
> 
> [...]
> 
>>   		nsp-0-0-0-thermal {
>> +			polling-delay-passive = <200>;
> 
> ..and here it's 200 - I really think there should be a single value
> that makes sense, this seems no less than random

Thanks for the review, Konrad.

All targets added in this series use polling-delay-passive = <200> 
except Lemans, where the DTS already has polling-delay-passive = <10>. 
This series only adds the cooling maps there.

As per internal profiling, 200 ms was chosen for remoteproc/QMI-based 
cooling. I can send a separate follow-up patch to normalize Lemans to 
200 ms as well.

> 
> Konrad

