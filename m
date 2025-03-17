Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F02459E3
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224389; cv=none; b=qzr6u2ekGITpm3JIJnCuR5q2FRWo9B3R5q/ZSADWIMFxuKXc6eHBPd+vAgRKDzJ4T2rq6urJ6oBN/1TKd7g+qFe7OAFB11Co3dc30zphlnqOTiXQ3qLNCNQ6f9Aad+9S1eUrhKYSPwv0cHos6rEoYwAqwfPe0A1/IBph6jvV3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224389; c=relaxed/simple;
	bh=SDvhxwcv7TdKOadxWFuLJ0D8uidUwI4ZDk4N4XVcyBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/q0YLXLW7IUE4aAOZr4vIGRYxLJuzaMVqWMR2Aiae6jD3XG+qzFREcaa57ITFUu3b5PloFQqYa9GZCMkNmXx7dTUAdLGP2YUoU5vJMWwwf3d7qu9N2ng8dIznWlBoh0pXBL9V7feipPpmpz/hiJPhlAx1mRFqxDSGXP/hoz75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=StjnEUDG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="StjnEUDG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9UCOR025176
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XrJDaL888EkzEDNTms51lcge
	hu13HyvkuZYeEeKlbI0=; b=StjnEUDG6HNwZOosjSO4sPdkSWSEerifWKGBiaKE
	lVmmEaBjWxY/W1GS1rwaD72c56MBuTFnAiS+7SWgqHdLz6LiE614la/w/GE0Nouh
	FRz3T4GWz3FLsabJgWRTIYorrhZOhwAXUmiwFnCAycFSDS40LKvBulGgykavLe20
	jMy7vr32YepPTu3TFX8ZnCtSGkEN/HD/iepI4D+QGJZeyhL1aCM5vKxzvXEbeQy9
	B+jAMn7ys/OxeDc+lMZNq6yj5f/5izIJKnxFbt36dVvbTI0WqeKb4wdNCgbixtGL
	g+PJb2H5pV9J1hO1/nzndns7nJukZQ4XeaZDShFqgbeNwg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1s3w58a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 15:13:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e905e89798so69846916d6.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 08:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224385; x=1742829185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrJDaL888EkzEDNTms51lcgehu13HyvkuZYeEeKlbI0=;
        b=hsBY0b5j1c4Domo5Rgce1y8vRXsTs99jV+vLd627Qr2UuKYQeKSGZGK4XJAYQZd850
         VPWdLTLuvZxz5VjtxBJy+trmErcpCRtbZtQFr3uIfRaEQTrGa4ribIYf34l+6zySbxVm
         G9dQKXefLhFrJrap+CXGrvxCMwrTcN7Hgy6hjbgo9NfprkAiHytRxFX8H7FVhnWIdooo
         TqRhYxMIcjIekvSjnw/d6E+NJKiCQbKISN5hcTNgz79nKTog7vxOzp920pskA8W/jqGG
         xVSf1dbADUiGyvdpSIfSIlVui23n20n8CrBmYkVUrMhcgEbtiGOERPIZxnusga/JY1KB
         qMQg==
X-Forwarded-Encrypted: i=1; AJvYcCVJBwX3lCS9IMJgP9DH7d4OUdVDxMMokgFRaoWHwQwUdBAXF/+gy+vWuFohavGvbWgjGuRPe1hmieNM5rl01+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD2VUmBSO4mFL9m1gGaSENT43NwdsBmihusd9YzG9uZH7NxF3Q
	iO5bnNBZV0MCM+e6VrBC4H5TXT2UFYHUCT8HIkzn1Fkya6Q4svp6cmWUOdACcy7liTFa1Oz52p/
	MhnIjjI/i8I4pLmSBD/tGC6y1GVawJ+zY8cUE4HBbujCxcQokt1OwFM/1q4bbfYBKyaM=
X-Gm-Gg: ASbGncuaJ7lnAlXm9lyJnPY/PV+P/ooZ6agRjwg55N2azo6cLxzZ7jDG+GfAJjvsidy
	vEfloulC8qo+ccBao4FaKxrNNy9rtdS/vBI09K24pIOh1mUfwYrXYyT6C3e8cNJSDA6Fdv1n2kB
	GIybINklhaZuwM45OkWtlp7s7iNn7r9jzSAXdTiMnnXy3rQkSsvjyNdEjkyMtniNDmNgnmbzyNs
	OStTRX1Ja4oLacuBweOOearhQ6VmBmRIqHFddYTMyF5Hz5+yEKCkWNDORsmxVH46CDBbKRzMQRX
	4Rs2eQiXau5G93PBRW9o2RIqiudRZAE8Dc6m4VAKGGxIfqpKOFhxNkFwtyHAz95B5iPLXJ/yg59
	92SY=
X-Received: by 2002:a05:620a:c4e:b0:7c5:9788:1762 with SMTP id af79cd13be357-7c597881765mr208498085a.45.1742224385482;
        Mon, 17 Mar 2025 08:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvAdOfSJ60Q9e2nCDna3LhjC5zfyZWJ3xn3wOOtOquU4EkmFzJJKQlq5NRNd8kCa2QmdisMw==
X-Received: by 2002:a05:620a:c4e:b0:7c5:9788:1762 with SMTP id af79cd13be357-7c597881765mr208493685a.45.1742224385093;
        Mon, 17 Mar 2025 08:13:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865096sm1355327e87.132.2025.03.17.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:13:03 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:13:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ivan Belokobylskiy <belokobylskij@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
        Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v5] ARM: dts: nexus4: Initial dts
Message-ID: <7z2u2almxk7rnd6cx6nq3ypgbzvttkj3jqawv5jojayjz3foix@zprthr6awbcp>
References: <20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz>
 <174221818190.3957236.3364090534153729086.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174221818190.3957236.3364090534153729086.robh@kernel.org>
X-Authority-Analysis: v=2.4 cv=WbQMa1hX c=1 sm=1 tr=0 ts=67d83c02 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=pGLkceISAAAA:8 a=8B4Imti52KGAqkOr0YMA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: KgvPbBTU3WLsuCGYG_bFJfNSNVJyeSw0
X-Proofpoint-ORIG-GUID: KgvPbBTU3WLsuCGYG_bFJfNSNVJyeSw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_06,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170110

On Mon, Mar 17, 2025 at 09:18:33AM -0500, Rob Herring (Arm) wrote:
> 
> On Sun, 16 Mar 2025 23:16:55 +0100, David Heidelberg wrote:
> > From: Ivan Belokobylskiy <belokobylskij@gmail.com>
> > 
> > Add initial support for LG Nexus 4 (mako).
> > 
> > Features currently working: regulators, eMMC, and volume keys.
> > 
> > Signed-off-by: Ivan Belokobylskiy <belokobylskij@gmail.com>
> > Co-developed-by: David Heidelberg <david@ixit.cz>
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> > Changes in v5:
> > - Sorted nodes alphabetically.
> > - Link to v4: https://lore.kernel.org/r/20250311-lg-nexus4-mako-v4-1-3916c8ec7edb@ixit.cz
> > 
> > Changes in v4:
> > - Sorted regulators and added regulators compatible.
> > - Corrected pmic include and references.
> > - Moved &rpm outside of / node.
> > - Moved and simplify pm8921 keypad.
> > - Added chasis-type.
> > - Dropped incomplete WiFi node, will be provided in future
> >   contributions.
> > - Link to v3: https://lore.kernel.org/r/20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz
> > 
> > Changes in v3:
> > - rebased against next-20250307
> > - dropped backlight until driver gets converted to DT
> > 
> > Changes in v2:
> > - lge vendor doesn't exist anymore, rename to lg
> > - sdcc@ to mmc@ to comply with dt-schema
> > ---
> >  arch/arm/boot/dts/qcom/Makefile                    |   1 +
> >  .../boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts  | 341 +++++++++++++++++++++
> >  2 files changed, 342 insertions(+)
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/qcom/' for 20250316-lg-nexus4-mako-v5-1-79feae815a85@ixit.cz:
> 
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: hwmutex: 'reg' is a required property
> 	from schema $id: http://devicetree.org/schemas/hwlock/qcom-hwspinlock.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: hwmutex: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwlock/qcom-hwspinlock.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: soc: replicator: 'ranges' is a required property
> 	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: syscon@1200000: compatible: ['syscon'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: timer@200a000: 'clocks' is a required property
> 	from schema $id: http://devicetree.org/schemas/watchdog/qcom-wdt.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: sps-sic-non-secure@12100000: compatible: ['syscon'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: rpm@108000: 'clock-controller' does not match any of the regexes: '^regulators(-[01])?$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpm.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: syscon@5700000: compatible: ['syscon'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dtb: replicator: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/arm/arm,coresight-static-replicator.yaml#

As far as I can see, all those are generic rather than being introduced
by the new DT. I'll send a set of fixes soon.

-- 
With best wishes
Dmitry
