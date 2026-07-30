Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277A3914FF
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430728; cv=none; b=PhtYkPI+AWCkfo1Df3nQLtJMjY3GnYQR69dJavioCH21nMpRi+DqMC0+bIO0b3LWR9sZujt2VVI9Y2amqxnYFAR0yFKwpTW0LYMj8+5x77x4dDSmz4cSrSFCleAlvkGnwgdhZhr4Lcn5EXL/kaIMkV4n3VZruZ/sGnjYVttFqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430728; c=relaxed/simple;
	bh=yhlCck/KDmo8x4hISNGON4b5jPd6JvYcp95JUqf1D9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il8oO9uT+1g3rr3Z4NGY26Ahku5+uqAROahBUAkFaEpb0FiwuX8zccCaQzxVwLPyjUFXvFN/I87ji9ZlWehkjan9W/WuvtTyRFgsWuJmFUM+gfZZJaohsgfAIFeDTozZ1duXam5CwRsB/hZo+zEYpUeIpFUjWGhCwGQXNDh3at8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKEqxsdA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dDWvEkEe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKEqxsdA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDWvEkEe"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UGWa9B1379383
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XxJhYT9rJBQN+jgGnlG/gzNOb7ETb39jS0PzIwxDi40=; b=oKEqxsdANJtmaVLS
	XByc0YhnUktWimqsANb8g+jXgIbH3Y1hgSHAzisDh5kiJdUDaYgVet1aWYHzwxnf
	4EZzSQjv0CrXV/L7yAIm3GvY7uoX3bvecFwUl0KZ0UasYzTP/2hGwE4u25MUemVK
	GlY8usLv7+RzH1lVQZ1vys65KsrMJt+uNosoBsvsUZbqwnT5nr4uqNUm7z3RojhZ
	6A76AIM7W+m5Ct5ya+2879KX+c1T5aqbmwww4snSjCSd1ifaa8jugIWMJipkpTBj
	PY7Eu8jDLEVeVL72NAERsP18CHz2i97FwlX4OQ65NvNilGVUeA7xfFw9V+0x3S66
	6+6aAw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8kn0rwg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 16:58:45 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81b0c72826eso1680567b3.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785430725; x=1786035525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxJhYT9rJBQN+jgGnlG/gzNOb7ETb39jS0PzIwxDi40=;
        b=dDWvEkEe/DAyDixHAVnWbAabzYvMX5V+eYtRqsD6jHRwhzUJjYQ+D7rqYeVFPrYbTE
         le6GWRyvH2CYc1fKW6F2dlc5eGvBT+zR+M3JiDKRKM0qZMcfueDjCbIB04UDSXhKelxW
         9jUVQQG+aarTODx8yzD8xeYUY4O5U7D2L9F/5xfqDjjeNjJDnP9y8/uCn1NgJ5ftwhm7
         ki1V8z1wuFDWloiakEAacnjxjoEFVv1+4RJYbWzo3yGfoZ+LU3ot3aDZd0+sX843OLiH
         IMYskhOIzCPun3R7k2y383zVPJCJ4w7FGxeJft6XgbmIDhnnLfSVrtAgjHS5MGJg7df3
         D0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785430725; x=1786035525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxJhYT9rJBQN+jgGnlG/gzNOb7ETb39jS0PzIwxDi40=;
        b=deaU1wUmiA8B6NRnSBQTjM9HRpmP0sBp2JvCzUjoHaq9G8zQJFOB31Y3LADJz/kKej
         n3/FZlNvODp5F+7NVqyVOIbGe6As5w5eE84OaHoPefoSRd9fHk7VsMUbKFHpq0Aewsbn
         d08x4gVArEtBhK3ZZaBJrKnoO9mpsGyaM3NVjslknG/nUoq6LuqUH7nnM8MeYytno/ob
         uclKiHTS+6qm9eTOaoRIp0lJ+wBeVfWHrGqzdTrRuBHfTgn+ZENIpafbu+Lt3QeArPqw
         L8j98Emw23HUq8alPy/Ots3lgefJuGw2Iq1SVsfKv07ywQ8SmhbsxPATkYQwJk/uDIKA
         vKJg==
X-Forwarded-Encrypted: i=1; AHgh+Rptr6rDw32c34uYM9pC75Wlxqvf8jBK2s/SHf968fw0+GdoAUfkUgMN3QIi4CPs8QLCwn6R4I6lVDQOikcN65Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKaUCoaV+dViKZ3GSKKmU26/l2bbUwtXy4NJHRhGVNBh8fdrw
	eI0O7w6UaD9TN59mvs1vczjxzgTPsGNNDIL2RCUAnAjX61EiJnuxaD+FSJGoGvU3g7OkNgyfNG/
	7eZi1WWVhSn9AKDLYV2kQnq7eBUXrqYDejduBBtiqCWarHvL0/Tar82bhw1himruAoamrEWU=
X-Gm-Gg: AR+sD10c8SnAypKwh0/8djPk/rXEoq8CB2GG2VdxKjCooUACnTs0FWHLfgu3tsVmIDY
	qyvnZgHWQ4mh11jEeJ8PYRA7I50pcCUjtZSudJXrv5etYktBJaaDvEU0uBWcTZxIEguWwbw3lIF
	1wUFFkNWeJ/qecxhiDCiM+R3iokfb0zi8U9Vim0HUB7yeFP/mamT9Zjx/1Ppr/9R4i+f7C4lXRv
	4/5EJw3fz1IQslCuy87L32rl2abie2KRg/1Pkht9H/YokGJzOLlYTWC77pzXNVyYeAeTFGOVQmH
	aoSPKZ19SwNTep9S1V9giinE6QBIz+i6keyeKKr5q1pG/YqyesgTLJOcq63mgnWyZNdXFl8TlBt
	P+eEec29H80i12BQ22dnkebNiZDGi2ReydYKCt6LvpMDmhZTmzioaqTNXyv7QZJMhNw==
X-Received: by 2002:a05:690c:e1c:b0:81e:8d95:3d32 with SMTP id 00721157ae682-81fb8944a72mr21469837b3.9.1785430724833;
        Thu, 30 Jul 2026 09:58:44 -0700 (PDT)
X-Received: by 2002:a05:690c:e1c:b0:81e:8d95:3d32 with SMTP id 00721157ae682-81fb8944a72mr21469587b3.9.1785430724395;
        Thu, 30 Jul 2026 09:58:44 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:2206:62e9:bbc4:c360? ([2a01:cde0:108:24ed:2206:62e9:bbc4:c360])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb88c4ea9sm13592227b3.3.2026.07.30.09.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:58:43 -0700 (PDT)
Message-ID: <f30954ce-9bf2-4f6f-90cf-4442390f281c@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:58:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
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
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
 <20260727-b4-qmi-tmd-v6-8-973cd3a226af@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-8-973cd3a226af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyNyBTYWx0ZWRfX2crQx/kKdZi7
 /2i6g2H9Q6a1a2w/k+/X0Ns0D1N8al9Exjed2DPfrjAN5Pe2MRsDr6A+pJE10USbV4hqKJqMMye
 C5Bw3jflzmOsEQeLBtbdXGbCUvBL4Ws=
X-Proofpoint-GUID: gmXED5E8iOZ9LyXHe9hm-gKfeh_fac7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyNyBTYWx0ZWRfX+lOgWrJgdbwy
 3YXgKq5W4ODZ5ex90RmRlfw2tNj0ZFEAkGstblZdrQvFT3m1DWVwn0ig/VqLqmKIOW1+bM9OBRi
 8XPw7qPs0D2VMfHCnOl98uNnwlDk2lRGa4+YWibb7y0UE8qu12dsA9vpP3x3QSQUp6b51Qx8NGQ
 avAgtP9Ih3/5m6jYjk3IlZm0itk433ZpiCNbVUza/aulHidZz9HUyA3v/9oHD0m1TPA50fsc0Nw
 r1iEuYSsDNz5VaSrTD1FvaW4E5ACcuItfvAC/t2SFlvEN7N8FFugXGAdTrJuauFOzAwJX2MDvvT
 bMemrQlpeNH+g2X1WIAUnwl/TjXNtFay9f4uw10URLWnn98+11x1kzwMug/FAQNG9+okyiC34t5
 euNtf3Hbpw1AexZCG+gKzfrZ4RnlHs7idcVzU0eCMqL7zUGmq58aKLI3fqas6iFwQrZwo2c4HcP
 nXrdO36ZbPOwIYgq5Wg==
X-Authority-Analysis: v=2.4 cv=V7NNF+ni c=1 sm=1 tr=0 ts=6a6b82c5 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: gmXED5E8iOZ9LyXHe9hm-gKfeh_fac7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300127

On 7/27/26 16:22, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 115°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
