Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712811;
	b=AgniL6g9nFdAn+byWKGVoLyEeZ123jXBW94d9GPw0i4APIoZvI5Layc8ADVroKK8M5kj
	 97B+gha56/XFquxv3vVMKg8S+rM1cyFKMepHHRAHF1h56PNBY5jlOl+ZBh+aijf0hoWK2
	 Kqd+SMh6qxEgfo7UD75eKG9CTzt4MhpxfR145EXfKJzvGIvazAC0ZFzdyLxyJtBtWfvwk
	 CDcA6fR1kzwGxzibdGCa/VHrNKveR3IDMxSyN7J9bw+wuOFsmVgB/6pNuL+c5Ggdfzalx
	 kD6U54kpT7d7hZmvggBt3hQGbf4hVkdgOMBib2at1D03GmyByasItq/KrydWTheYMJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712811;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iQP0DffgHZK1//+ou8ZDmPpNoN8WnAJil4ETuCdPbuw=;
	b=WEFWn8/zcorCKACfz8cNTH5vAO8M7F9iScfbimzgUZJImux5S+UGXYOUORKBKE6VIDuH
	 0F+gQDhfX9KItt1wMQLSuy8EKhGgYFZgHaYeKO6zS59cAfRYnBYQtKSxsE2fiXVmZIbW0
	 Jn2AVUB3qxMbR6/eqWn7G6NI87iCpUz9SZOmcFiHlwjDFLp/ZSbu4DjroREdQxTIsRT5e
	 ZpQk4tDEkJglJH/tAEyjGtUWFnEMkJCZFV0I99y0bwtyxMpIH+o0PzGFL02NgPIITwkG9
	 BNCfn8Ak/VEYMH4ZbZfuyKttRVx34sJhlncLecb9nMo4aPmRM96FJxwD9r3CRmEl/Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="MSO/3svB";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="K/frGJWR";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E8606D81F
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F8E8606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MSO/3svB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K/frGJWR
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Cl8VH2899277
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 13:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iQP0DffgHZK1//+ou8ZDmPpN
	oN8WnAJil4ETuCdPbuw=; b=MSO/3svBkez6VG0Vv+LeY1+7Kyq5hXZ4kt7PeNjr
	5c1IYcz5yvdrVLTXOKPQZvZ5osMXAPK2tQJ44o9TAyYiApulqHTN+bHa8Zs70oqD
	VDQE+WRZCxOGuqLg+f9cwFP7jpfisAsxDuSZjkYmd7xk+Yn/tv6WZ52cvXZBBGJ7
	RprlSD1WdkS+bEFanAit0B4fgrhT2Y2GRJ2wJlU/13El6CRqEDCxnmMa4G+QlQ+t
	quo0cHqNJ1Xvz0Kax83RdUB6gGAmo/VQ0HnxnGOzCyMAWJMuTg73G5ooTdj4R/PQ
	jMae2YFCv9sChkxcFtCnOugBKFiHtNTqQU1hcyNnXgOvyg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2ackbgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 13:33:29 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf634a101fso3522312137.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793712808; x=1794317608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iQP0DffgHZK1//+ou8ZDmPpNoN8WnAJil4ETuCdPbuw=;
        b=K/frGJWRoOoeH+z+5VIcBk9jtjcU4LdYas3VxJFUcn7b1bGOhJrcyRglLhX4qqzo1e
         Lcijc4l/e2CdmPfp/h1GUGOzOiT3czoVtqpPhH0AmTgXN+iiiFH66kJshmAQBb/zxxp1
         zjUR7Se0ULEDpvl3h1CPuuMMXbCpkqIpnqkOKrK4Eg5GftjB2chLqqSpBV3Pz06mXVzY
         OoJRIjiyDk8ypd9P/2BsVZWwfT0BdV8osE6YR26vylpSje0S0A6vso25W5A8TVdmKvOk
         kMonoPmvu77MY74bOiug9hFL12NdhL6IhFaKRWat2WaaHk+QfzWb01XAnezhOjuF22Ub
         rqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712808; x=1794317608;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQP0DffgHZK1//+ou8ZDmPpNoN8WnAJil4ETuCdPbuw=;
        b=H6wUtHc1hYnokQW8kqZIhE+MeTwKrVh4hd9SBkjE6jNfTe4rw3z+92htsQ4pDvgfN+
         5kyHTh2IVoycuBGz2q3UnFjloAbRnn3PMLugmtz3sFvJTf22fZfTmDl5AxJo4oQJSoyR
         lypbxvRkhhOtrrPtPy1DMYd10/mmA1gvYSNjJKyWg0MvHZpTEVUioBWbsvE3yOkyHnpU
         jyQ4pcwFCYaZB+MtVftgA2auxdo1EGGWg8AH0zZdbPC9PuyxCRve5K6SNflLadoild7d
         4Gy+noo7eKoP/hBEu1RGNR99IULN9KUxwo6qcNfcI5+hbyb3UhBJyiEQ8pITTA0KNRB1
         KiGg==
X-Forwarded-Encrypted: i=1; AKwUvByAb2r+JO6vK4QpuOh/Q7j9+cY9hgVtUnljUFeGKFfgfcJbgHIKbDzrSGpKT4CL20HikS/uggRTvV+tHHIi9Oo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U0ZYCoXzBt87Rpm9PgvRIhVOxfhOlHiyZPv1r4FXwjB++yF9f
	KNIMaAFE6WlFD6rF/4W0vukcNnLkYsL0kYNlgCSptThdhKBRtrI/1uamkKnuvURRGoU58FeuIb5
	dcX6schfXSxRN7AvoFugfvXBeRkI8yQ1VrZBIo7ScIc1qsM88il0BfTRTSr+LoIc68eax6Rg=
X-Gm-Gg: AYBFou0+buvOPI7LqcZ2dJEnceiz7T4efYb4WEXN6es1sYR7v/KD0VzYlOOsw1NOFzM
	y6l+iO3KFAxG5jsMr8kMaFlOeaRlCrp23vzfRd/PiB9Hj7KchlcJ+yW6AyOV/Tg+5OE7SlVw55c
	x3Gq7C6VudViTUxdWAV4AbxJbITZDdQ6l+fOy3kTXg6/esbYSn1LxJo5rItuR7pYMKPA4BjJr1R
	4opv3DmeoBJKaRrdgswQzBm+L+U11qfFpwcYHjjM41+i8V/EcSxwfJviKfpILjAdBLvqI2bdpCX
	lByl5uwi8bnUHfY1PS4dmH7VBMbzcun0NGjgqHtRMXac7s03VIKCl9yNxk6ePvvTZHIYelNbg1B
	wIryTVtLEbI5omezKoWnp7mbzwuhLoFzKfqMl9F35mORmm/GXQ8JYKkHSHE32JKY=
X-Received: by 2002:a05:6102:292a:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7d07262d5f8mr5193737137.13.1793712808391;
        Tue, 03 Nov 2026 05:33:28 -0800 (PST)
X-Received: by 2002:a05:6102:292a:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7d07262d5f8mr5193716137.13.1793712807714;
        Tue, 03 Nov 2026 05:33:27 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae0f4sm22349359f8f.58.2026.11.03.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:33:22 -0800 (PST)
Date: Tue, 3 Nov 2026 15:33:20 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Subject: Re: [PATCH v12 8/9] arm64: dts: qcom: shikra: Add OPE node
Message-ID: <zymjeclhd2ezemd6jeujtsu4y3gb26gi2v4vd3gmi7diuaa23m@aqr4blf32t5b>
References: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
 <20261102-camss-isp-ope-v12-8-702254689feb@oss.qualcomm.com>
 <bac09735-4136-442c-9208-556568d39967@oss.qualcomm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac09735-4136-442c-9208-556568d39967@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae9e2a9 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=AvtK1wfCeudOeV3Kv5QA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfXwJYdV0E7rwML
 6e7j9wuQYEtSmy8mmHGHdE+y0YWYq9/CLnmpp/gR+VQkwTXHXA/+In+rZf1Uor5zG87xEfvhoFi
 7TqgPmHCwmhTAYJ7HySjX8tmb0Pyv+hskeOONE+jJhChY6VFm+WUkOMckVhtwD2IDDCRDJHMRW2
 d/6PrT9Lo0Ot3/fFKSQ5P+KlSpC434tVQ+DG0R3I6K6j2fUuJpWq/2l8oCtNWClVI3HsBM+1hZS
 AdTV7Sz032rO8i3OBdSk3raaeJkg/oSN1XiYwO39W/B4KxX8BYk+Dw6eAeXCH3hzDW7p7tmo319
 OjnYS4WPpgliGxzCszZL3TCin3U729TLtydY9SwhJu9c2LE4+zNhYn6lmR4FWXHMOP8JjhnHfRG
 vvxJGai02g+bzUG1p9LiV/z7BbLGBTCZNSIj62R4ih/HanAYLEOj1511TwTp4NEpqlU0u1Hvnw4
 RxNWYCKKyqAlkbBlODQ==
X-Proofpoint-GUID: JCkAmQBBb7aZCYrh0eUrCPXDnoRDLz3t
X-Proofpoint-ORIG-GUID: JCkAmQBBb7aZCYrh0eUrCPXDnoRDLz3t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfX3YrENrU0BhQH
 8U4XDkCCxCxKxd786t5Lx8eQ4OoeFmW5lP3J5CocNS1NKHOt9NEqYT84f6DlYFipqqSHn5SZc1R
 dl7qcAkMTy4qPfa0ZKw7OFNsR2CCHg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1011 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030053

On 26-11-03 16:59:05, Nihal Kumar Gupta wrote:
> 
> 
> On 02-11-2026 21:17, Loic Poulain wrote:
> > From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> > 
> > Add the Offline Processing Engine (OPE) device tree node for Shikra.
> > The node describes the six register regions (cdm, top, qos, pipeline,
> > bus_read, bus_write), clocks, interrupt, interconnects, IOMMU mappings,
> > and OPP table.
> > 
> > OPE is a memory-to-memory block with no board-level dependencies, so
> > the node is left enabled for all Shikra boards.
> > 
> > Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> > Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Tested-By: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com> #Shikra CQM

This tag will probably not be picked up by b4 and it will probably confuse
some of the scripts maintainers use. It needs to be "Tested-by:".
