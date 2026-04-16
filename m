Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206833DED1;
	Thu, 16 Apr 2026 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380183; cv=fail; b=BPYjUf4OVgK9xuHGnZCeOavqOjZ26bJvSrbklv9hP7P9BvTEiM2m1LUVO4Brx+V4HjdTVdcOWkGb9db8W1SOEVWN0MEA8tKiW4MowiCpAovwO/4Xq+cIpF2JYt84WCdXJ7IsU+agsXrMxidCxZcqHYUGvtaCZsm6NE+ta3M8EQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380183; c=relaxed/simple;
	bh=kNejwV7fQziQKzLJ40MIEiMO6s9hbU4YL90N46+/kVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q6VP75w4+yEKja5tkDCUw6tCMAfAj8Qn5iPw3YUYw0WXgkcrNyBA9zckUjcPh/tg6dfTPpErwR8h6EPIddWUqLiJ1B1BavS/Af/pdqDRIzgi00bskR/CTPnHny3n0tfmEdPVC9aUiCwvwqm0/DJNjAhUTWvDT999akFuDn3mxgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AHT7/eLS; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=loDUUuON; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BLajoP9A reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AHT7/eLS";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="loDUUuON";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BLajoP9A"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GLZjvC715698;
	Thu, 16 Apr 2026 15:55:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=kNejwV7fQziQKzLJ40MIEiMO6s9hbU4YL90N46+/kVA=; b=
	AHT7/eLSMLEkv7G6Q6AYUmeSbRSnMrhJN4+TWWLEkna71yRfhSo/YNm4dRy0x+ah
	QKLXdTgC2syJZssBOQuQErZSoS8kmzThiOqGsxXteMo1xyQ0CZAmAcMqh818PwWp
	XTiYH70KcFV+Q8Gd/yneLi9wuSkCUV4GbQZy4hBJUP1ma93/PjBBnAOZ4PN/hzly
	MzSrJAsj/hlKTQr4xqfr9vf/mvIvpRzWsprb649muEVt+EChz87Xx5c0yqdsRYvy
	oQeBlIkR4Y4PtJXiUebrug4uAaqGD9p/ydUqZAeMlVp7T7ZRdw+ENwrC2ePh5twS
	g+DZXy9tuSTujYFiHFDHzg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4dk4dd9swh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1776380157; bh=kNejwV7fQziQKzLJ40MIEiMO6s9hbU4YL90N46+/kVA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=loDUUuONjsv3ushy+IQ5mP+5yjmuMvJZkO5Yfi1ewmuo9ftLZnmHYiqetCcDaDpzA
	 vnGQsmLNMX9vJMFMoFNQGa+GQ91MWOxtq9sZsbfgb69EyMI/8jQN5I9ZQtysS6h/n4
	 dzP1Pof7Jd+/DbHNsd/qLKNZnvodgqm36mSYdCcb2joycVjmOsg6ZuUV4RqQ9gghyM
	 aaXeK3KAAY8lygRwqcZB650OoZ/zV/1pK+O0j712o0LBIGnL0PIPB5xujG1UZ+ejZH
	 B5cSgKbmcldOk8JNxSIgKhOQgEEqjAogDXugluiaezeZtEjmlJpmyQcVTcV+dKRUlV
	 2IdM6RkBCYn+Q==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4D7994010F;
	Thu, 16 Apr 2026 22:55:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0F192A02B2;
	Thu, 16 Apr 2026 22:55:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BLajoP9A;
	dkim-atps=neutral
Received: from PH0PR07CU006.outbound.protection.outlook.com (mail-ph0pr07cu00600.outbound.protection.outlook.com [40.93.23.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8C3AC4021B;
	Thu, 16 Apr 2026 22:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEcsAm9nVGbvUnYfkvtuIMIZ+8CLyG9HdOsdt6IOH1qA1GrfvOjYbhHjqac6479hzXyAZeHUksFOTPipPcvOL97nXEM3tsnUK+lMDIS04Fm4OpYdhZ9hB9fT4q+yK+gwoYwHakKs8wAc19+pMw2Tm7W35YgE3dvgUg8AEhStnhG4Hfk3VfRtGgoZtgTdMeMBwNSp+hXmZpUFr7A0byLN74ouYp2b88Vc0loOBShKivLucGORIdtMl6Iuv1sPt0FLu9jEOpPiFIsiCHe2nfw/QW00IEjkA7i9tbz+DlK2XQsBENVC3eoTcuzL7Q0yjW1MwGxCxsY4wqZyxoI0DrPwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNejwV7fQziQKzLJ40MIEiMO6s9hbU4YL90N46+/kVA=;
 b=qqdstVg93oBGOQv/dsM4mnHfagdmHniasfZKBw3MA8BwARe75JnpYSbUxov3mvk1Z8xJG5UmS8TYO3oG52baJPRoD2kp+3n0NskbBpndXFeHIeH3n8cTndnZIiia3S/OpFqCHTfSzXhHuTvoqRcMchWZwZhdeCN/5lmqa8N/+VQm+1ELICwPs3g/vU8ccsejn7r0BOaBXKae/FngaL4ZrB4dmv1DKg7TixixBrGN9b79gqxJpt+KvG23wXwYeYh/38tTSkwqJW83sq6tIo5hMuSK3EoDu3rGBSK3w2PwXuoxU+1N/8x1toByzw92YmFceCvnvxrJTLvL5Qh8DfJLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNejwV7fQziQKzLJ40MIEiMO6s9hbU4YL90N46+/kVA=;
 b=BLajoP9AsLrEBQfEPKndvqYOEYKxPT11NITptTdGuVt7545ZksSEW2clhsgNUrGNIl/n0jmGDYCMezqCy+2CJ+fbtmrPj3u9w9mSWsDcSQJNr/VGcnjEJvD1IZ8xBEO0wqRQCM6I59eP2bcpWWvX8wMA8u3FxMhVy7yHKfzqnwk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 22:55:51 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 22:55:50 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Rosen Penev <rosenp@gmail.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL HARDENING (not covered  by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: qcom: allocate clks with main struct
Thread-Topic: [PATCH] usb: dwc3: qcom: allocate clks with main struct
Thread-Index: AQHcyWXzTmC4YSS+30iC2JN5o4RlH7XiVXuA
Date: Thu, 16 Apr 2026 22:55:50 +0000
Message-ID: <20260416225537.wrajd7riin6ynut5@synopsys.com>
References: <20260411034719.161736-1-rosenp@gmail.com>
In-Reply-To: <20260411034719.161736-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5940:EE_
x-ms-office365-filtering-correlation-id: 15e9a852-2e47-4fb1-113f-08de9c0b4e6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 vo+Ys0TXbJb/kQ1RltQK5Y8cZVJaYuhOkiMORHOEnNQYGlPKt5POEzbFpvR7oIQpSoUS6PsV/5K9BnVi87UBVsL+6hTi+BxIDL9vEbqufnioJrvSbNN5M411mxR19xiX+jgsV0gjH+5vg71hO91P9R6C4Ku4tkgwnaL8CNUKxRrgKBPg4HEC1C6udlD5jcRTkYN+zTzXJ7PILCQOEHw7H/rDSJz0zXp51GBBcjx0kuMHCcia7+a3TlO9n2QrjmIgp2UrmsAUxZL1x6UQ9CmBuJrCrXR0FfKLyM3sf5zDcx8Uwgo7ZXtpiJqvtHCdE0XHpCuET5D2KSzZIAPpEgJpRN6JPsXQUBEyHBluN53T3kPIayKfXJJ2RaIY3tlGokmCFV8icNcKAQ4Dg1jlhulFbndTfUEdPSClJea48QaqPp21MQ/3DqbRNlhCvQj7LO1lRbJj57ejgFO3UX6G1agFK9iQZw6xnJi7us9Ob7Ef7+2spYj4LVYWm0I/1OV1QyMEJQGY8hGii02SL2ufWeclfs+RFv4jgYcAjl2ZRokTwVmpHPnCDcIXKzc/WcAi00rSltEHL8tvKyYRqPlnUEJmTGLBTmrirr3KzKvW0VGht0OASqH1R1sverq+MS6sODjeHe6Yy/MLaVTu1rwdqz6EvK6npEPcsP+RVwSS2TPwK/t5h/uGi4ytlRFNQXwzF5Yf0E1Q40Zs3ySffZ8aTcTBF8pfQWVBK/wgJhlSb4ZhPa5vhiF4gveoHd1AUIQ/EgBNJ06YluZvO9fWgN2DuslWVuwpCZSjCKtchECRigDyZEs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTVUVzYwS045QnVkZHhkNU1TN2JUbGZkWFQyMGxoS3FXT1F4ZXFkR21OVHdl?=
 =?utf-8?B?RkZuK1NMSXdLY0k3cy9jSmRZTXpNbW9IR3llR3NIWndzb0p5T01CRmFZR05E?=
 =?utf-8?B?d25MaHlTSGZtUTYrbVY2TC9SaDBKaFhkQUpSeGpmbHFWS2FjTGd3b0hmTzNF?=
 =?utf-8?B?amlYZFZpVUFNamhuSUg5eSsveVlweG9LakVaNVZKNGJ4cE9UdE9ySXdQaEY2?=
 =?utf-8?B?cU4rbittRVBkWEUrZE1pdmRCcjR6NEdSYitkK2NkdHFCMzg1TlVkUzFMSFVl?=
 =?utf-8?B?WHhYdURxRTgxWklHWXN1NytvTllJVWxJRmkyZnZWeC9nNlZWTGw3b0ZNM1l2?=
 =?utf-8?B?MGxtdmdRV21QeWhlSW1oaVFmanh2UjZOQ3lWUHU5SmpuTk82NktUb1g4bHho?=
 =?utf-8?B?QllTNzlIcXFzbzFCZlZzaURYT2Q3TnhjdzNUN3hycHFmalJUbEkyNHJKM3Ft?=
 =?utf-8?B?YStGUFBBc2ZNS0F4TUpsMllaaWlIUUJtNmFHS0dmZkNmd3FLWW90bW90L3Ro?=
 =?utf-8?B?WWdISk9qRmYyT0NYSGplRXlXR0xSaWFIcTFsNWNUN05Sa3AwTnM5bjN5SVoy?=
 =?utf-8?B?T3BjN2ZVWFVHZWhGV29lb1N4YnFPb25yNDZnK2hzQnJyVkFqbCtDOVRSaXVW?=
 =?utf-8?B?N1FpQVBqcGYwRU5tWUNqOTFwUFRXTHpjZVExRTZ4Wkx2YTJETVZydDl1STZF?=
 =?utf-8?B?dW1CT29uWGVVakt0Z085ZTVEUG56SkJ6THIycXpEN0RJalNxRTJIeXdsMTVI?=
 =?utf-8?B?dmkvWXZyaDBVT1VSSGVJYlpQaGplWkdzcys3RG45VG94OEFqZlJkWW1vSG16?=
 =?utf-8?B?d3NHbmRMU29GbkFqblhLRUFiOCs2dWJERWlSSXcySW16Yy9Va3o2ckRJczF6?=
 =?utf-8?B?OXNtc2l4Qkx6US9BbTV6OVpUTlBvUzNkYXE5Vmo5QVViWmNIUEhFK0J5N0xY?=
 =?utf-8?B?VXN1TThmcjNJMUZMZHk5WEw3UU9BU21mL29uQTNpV00xbUg5a2RxS1Y2cUZP?=
 =?utf-8?B?aWNVa2p0UzlhbytyRFJ6WFBvK0hCb1FXc2Y0T2hRRDlvNUNLOVJsOXZwRVlq?=
 =?utf-8?B?OG1nMXBRUDRIV2w0ZlVOYmRiVmk1T0ZkcVVXaEdoK1VZT0Z1YnArT3lvdSt5?=
 =?utf-8?B?V1RleHNvS21ucWpHdUo2SDVPWHltN2RxUzVPZytpdjErK0ptdTZPaHUyY2d0?=
 =?utf-8?B?RlAvY2JvbTQrYVFpYUNQcjI3bDNRcDJVUzJ2WVdZM0MzU3B0Z2NVaEU0cnY5?=
 =?utf-8?B?OEl0T3FiSVN5MlhqYk1tQnd1M3FRaTJGK1psK3BHY011T1ZzUW1ZYnVuQUcx?=
 =?utf-8?B?YUFUVW9ybnlUZC84bEhmT0Mwckc5WGltRy9qa1dZQkl0eElodVhwQTJtVUNI?=
 =?utf-8?B?aVUwNVI3ZW1USktCRVc5WUc2NGRYNFFXaTNCM2pPeGp3dWlzcTBuYnVpelpC?=
 =?utf-8?B?MzVzYkxRVmVGRzJUOVZHQVE0VS9mQ0NzRlA2eHNDbVM0SDFTVTF0cjVoZ2du?=
 =?utf-8?B?Z2NRN0Q2MFNyWlJGcHAxNVZlNVdja3NzbG1wT2hIdXFaTXE2ZjdKdDV6ZkFO?=
 =?utf-8?B?UEE0ZE51akYvaEVTM1pWMTdFYjB4THQ0RkRsMDd5bVhQRlVPRU1WTGlTMkRI?=
 =?utf-8?B?bytQQndhMEFpazR4OGxKdmF2SnhjYnpCVjdDUkRFbTBLaytsVy9pMVp5ZDdu?=
 =?utf-8?B?RXhQempsRHpiNEl1Um5ubjB4ckMzUjNnUG9ISUdyQjBMMUpVZkFhZlpsdmpH?=
 =?utf-8?B?dWVmaXEzSnZHcWw2TmhXK1ZFR0pmRFN0WlhvZFVJWmF3eG4xK3U2WmN5U0sv?=
 =?utf-8?B?bWZQSlpuTXR5TWFpWEkzaXFWcVE3eGRERytITWNiWHgzZnFHM2o3RWFhUU5k?=
 =?utf-8?B?ZnlKOE85cndqWUpyN2FYelQ1YXN2ZWpnVUdaVTNqcXRzdmlMRXE3N3JmcmxW?=
 =?utf-8?B?L0hWUDFSRFhXb010b1RQc2xNM1RlRGtYZVJubDNReHBoVXFrVVFpbmVBVlds?=
 =?utf-8?B?YXRJTmNmY2NNa1JxT3gyU0JycEZrRmN0TVI1WnY5MStMYS8xSUF5RkxxZ3lR?=
 =?utf-8?B?S1h0S2ZmWStKOEltYjBHWjRrbk5XcHZhVzNPeXJsQzB0TFM3d1QvUFQwN3pa?=
 =?utf-8?B?dFhmc1FrS0VUUEdITFBISWRsaWh3RnpsTjFVVDhZZjE3UG5nMjBTVGMyTHpk?=
 =?utf-8?B?dEdQYU1PeTFZRkxzT3RqWU5JcUdsdjVWaURlV1Rub0hjUkpLRzhsSER4Z2FV?=
 =?utf-8?B?V2ZKTTZSWTA5RUIyRXZVVEpTdmMzQ2FHZ1VzcDZRZkRHSm5RUkUxQm9FbEtJ?=
 =?utf-8?B?aFBhekVaZTNReVpvQ3d4Y2ZmbmtuNXlKbWRQSGpJbEdDWDY2d2hEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D431CEF470A2A5469C3372E15489EAE8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	niFx0b4+4yvWqpAA+fqnQuw+nTAxyC9h+NGGxWlRg09fV0MzLfVrFlbWQ4+GbvNI41sKqVsb3wyHSMRHXu0fw0saY1ut4jeOnestZmW9sJ3dE5Znlz828WCvKs7hFMwCWz/OnwUKqHLIkUIw0wERFdYnZ4z2aX9yvgiZ0DPaWSLQc0SUu7Dn3nv2QHn48DJye8u0HPz0V63Db1L6n2n39I2mHSleN7AFKADtFCfc+EGVT8dQH4Y37Qjn2l14nDcqsOag/f+wI3puW2yyvI8uS0mxtjpxGhJKrMXoDnSxL+RLxBGRSLqWY8+YacMn/v8Z8GUTTPos9YdyJGlbdc6+tA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Rtsklh00vvndT0uY/b5UA89y39ZsGHVGTDv19Z582SCCDBpHEJx2SUxvyua3I6pOjUM5qfmT7JmTw4MpePp9wKm/rTYgdRsszrtktIVzC/d2Tn8GHMzZAxoa7k+AisQeENwVH9M04J9jbPeodgBV3JpzOtin/6cKu4y8cbrh06XTTniu1/bg3AB3XWFByjysyRVxWEGCBEYUKWRIjZ+gizP+gdkTV/g/VyRcsXruAf68K6A6eLPyBDnuyHbxOxM3/uI+DyT+g03nUTMh5uZkjnYvtdLTWFVaLXgiLPYb3A2s77/jercOv4418Ohl21ZVcKvg0m8zP+V0fOVqsDADiWzQqL2wb2PHsUdubDReZ34Eo5Fm/YVFe4mpJRCPGOcubTdkUB2PSxc/B43wqrxw4dwS5ND/Q4MVwMAoP0ODzyk6+mknhf09LqSnSB/fvAfADJor+2naeAbs35mjsU8rZaAIkCd3y+BpjJ/DPUsPia3ggi3MXVV8I/KMsRXWHopDO283I7TD8As0uLeZqM0d7+/gtNLYkKCjPamPM9peKUJ5OBgwjj1D2/o7mAnDMllwJPB4nviXuwMSX+zmJGjo7cBXDfpfRxS955dl6EJlnxekCtUS3EsU06iTDz9OpfLXUbCNOp/8Ugytt7wcXoHLw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e9a852-2e47-4fb1-113f-08de9c0b4e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 22:55:50.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJZjM4ivVg4R+q9K9PU82fyeM5rOu7CRYa3o7wiH43bczjPfHiV9rFO1/Glzoc9ZzOo0mUT4DwepunNUgN84xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
X-Authority-Analysis: v=2.4 cv=Zvjd7d7G c=1 sm=1 tr=0 ts=69e168fe cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=pGLkceISAAAA:8 a=0BOyVNAB8tdlYOhFzfAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FmZFCaHNgVqtsO7wYH_RXCf4mMofNIqg
X-Proofpoint-ORIG-GUID: FmZFCaHNgVqtsO7wYH_RXCf4mMofNIqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIxNyBTYWx0ZWRfX/mkA8bOpttRF
 9YqzzCbQoz+zh0e1eTvx0lUCcLgNPMQbI3g0t7O0mPCLJnOmD04xhT7RWIR1NM7je06W29GoHxz
 ISVOUUrzNg4Dq0EJe4yWSoYQHWGLanJ31kuAfzAOG01WxlIdBU4QC0CPy8fRAUW5yFkPdnCIjFT
 jmqmsykrwHLYmPaB4+y9QLuQopOfRbS3CXIHGi4kCchwYX88LMWVfuMjBSPUhxVxD1rOlM0wNgl
 NCym18FNFKlJdw/Gmlwg1l8ktCUUhEImCBQK30/C3P0/F4rCfm6NlQbpxz42KTdqW0T2YYm0pxO
 2MRzin3R+1k5zI13X4OKpMyxHCqrEBdashOH42EnLwtkzMJzQgcBRYVVyTV0a5y+l4m2+NSmpx7
 pIiq/4ws/l6Fk2cJP3NRYDH5efBGM/B9aAorSVgsS0eYwgmdsRpTByHZ9+tKPhEHDF6yv4I5ucf
 Nev97aQS0BMaAWoxRlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604070000 definitions=main-2604160217

T24gRnJpLCBBcHIgMTAsIDIwMjYsIFJvc2VuIFBlbmV2IHdyb3RlOg0KPiBVc2UgYSBmbGV4aWJs
ZSBhcnJheSBtZW1iZXIgdG8gY29tYmluZSBhbGxvY2F0aW9ucy4NCj4gDQo+IEFkZCBfX2NvdW50
ZWRfYnkgZm9yIGV4dHJhIHJ1bnRpbWUgYW5hbHlzaXMuDQo+IA0KPiBDaGFuZ2UgZHdjM19xY29t
X2Nsa19pbml0IHRvIGEgc2luZ2xlIHBhcmFtZXRlci4gTm8gbmVlZCB0byBwYXNzIGNvdW50DQo+
IHNlcGFyYXRlbHkgbm93Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9zZW4gUGVuZXYgPHJvc2Vu
cEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20tbGVnYWN5
LmMgfCAyMSArKysrKysrKysrLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtcWNvbS1sZWdhY3kuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLWxl
Z2FjeS5jDQo+IGluZGV4IGQzZmFkMGZjZmRhYy4uNTY1ZDAzZWIwMWI4IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS1sZWdhY3kuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtcWNvbS1sZWdhY3kuYw0KPiBAQCAtNzQsNyArNzQsNiBAQCBzdHJ1Y3QgZHdj
M19xY29tIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2Ow0KPiAgCXZvaWQgX19pb21lbQkJKnFz
Y3JhdGNoX2Jhc2U7DQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZQkqZHdjMzsNCj4gLQlzdHJ1
Y3QgY2xrCQkqKmNsa3M7DQo+ICAJaW50CQkJbnVtX2Nsb2NrczsNCj4gIAlzdHJ1Y3QgcmVzZXRf
Y29udHJvbAkqcmVzZXRzOw0KPiAgCXN0cnVjdCBkd2MzX3Fjb21fcG9ydAlwb3J0c1tEV0MzX1FD
T01fTUFYX1BPUlRTXTsNCj4gQEAgLTkwLDYgKzg5LDcgQEAgc3RydWN0IGR3YzNfcWNvbSB7DQo+
ICAJYm9vbAkJCXBtX3N1c3BlbmRlZDsNCj4gIAlzdHJ1Y3QgaWNjX3BhdGgJCSppY2NfcGF0aF9k
ZHI7DQo+ICAJc3RydWN0IGljY19wYXRoCQkqaWNjX3BhdGhfYXBwczsNCj4gKwlzdHJ1Y3QgY2xr
CQkqY2xrc1tdIF9fY291bnRlZF9ieShudW1fY2xvY2tzKTsNCj4gIH07DQo+ICANCj4gIHN0YXRp
YyBpbmxpbmUgdm9pZCBkd2MzX3Fjb21fc2V0Yml0cyh2b2lkIF9faW9tZW0gKmJhc2UsIHUzMiBv
ZmZzZXQsIHUzMiB2YWwpDQo+IEBAIC02NTMsMTAgKzY1MywxMSBAQCBzdGF0aWMgaW50IGR3YzNf
cWNvbV9zZXR1cF9pcnEoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBkd2MzX3Fjb21fY2xrX2luaXQoc3RydWN0IGR3
YzNfcWNvbSAqcWNvbSwgaW50IGNvdW50KQ0KPiArc3RhdGljIGludCBkd2MzX3Fjb21fY2xrX2lu
aXQoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2
ID0gcWNvbS0+ZGV2Ow0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZQkqbnAgPSBkZXYtPm9mX25vZGU7
DQo+ICsJaW50CQkJY291bnQgPSBxY29tLT5udW1fY2xvY2tzOw0KPiAgCWludAkJCWk7DQo+ICAN
Cj4gIAlpZiAoIW5wIHx8ICFjb3VudCkNCj4gQEAgLTY2NSwxMyArNjY2LDYgQEAgc3RhdGljIGlu
dCBkd2MzX3Fjb21fY2xrX2luaXQoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSwgaW50IGNvdW50KQ0K
PiAgCWlmIChjb3VudCA8IDApDQo+ICAJCXJldHVybiBjb3VudDsNCj4gIA0KPiAtCXFjb20tPm51
bV9jbG9ja3MgPSBjb3VudDsNCj4gLQ0KPiAtCXFjb20tPmNsa3MgPSBkZXZtX2tjYWxsb2MoZGV2
LCBxY29tLT5udW1fY2xvY2tzLA0KPiAtCQkJCSAgc2l6ZW9mKHN0cnVjdCBjbGsgKiksIEdGUF9L
RVJORUwpOw0KPiAtCWlmICghcWNvbS0+Y2xrcykNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+IC0N
Cj4gIAlmb3IgKGkgPSAwOyBpIDwgcWNvbS0+bnVtX2Nsb2NrczsgaSsrKSB7DQo+ICAJCXN0cnVj
dCBjbGsJKmNsazsNCj4gIAkJaW50CQlyZXQ7DQo+IEBAIC03MzYsMTMgKzczMCwxOCBAQCBzdGF0
aWMgaW50IGR3YzNfcWNvbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CXN0cnVjdCBkZXZpY2UJCSpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCBkd2MzX3Fjb20J
KnFjb207DQo+ICAJaW50CQkJcmV0LCBpOw0KPiArCWludAkJCW51bV9jbG9ja3M7DQo+ICAJYm9v
bAkJCWlnbm9yZV9waXBlX2NsazsNCj4gIAlib29sCQkJd2FrZXVwX3NvdXJjZTsNCj4gIA0KPiAt
CXFjb20gPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpxY29tKSwgR0ZQX0tFUk5F
TCk7DQo+ICsJbnVtX2Nsb2NrcyA9IG9mX2Nsa19nZXRfcGFyZW50X2NvdW50KG5wKTsNCj4gKwlx
Y29tID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHN0cnVjdF9zaXplKHFjb20sIGNsa3MsIG51
bV9jbG9ja3MpLA0KPiArCQkJR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFxY29tKQ0KPiAgCQlyZXR1
cm4gLUVOT01FTTsNCj4gIA0KPiArCXFjb20tPm51bV9jbG9ja3MgPSBudW1fY2xvY2tzOw0KPiAr
DQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcWNvbSk7DQo+ICAJcWNvbS0+ZGV2ID0g
JnBkZXYtPmRldjsNCj4gIA0KPiBAQCAtNzY2LDcgKzc2NSw3IEBAIHN0YXRpYyBpbnQgZHdjM19x
Y29tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWdvdG8gcmVzZXRf
YXNzZXJ0Ow0KPiAgCX0NCj4gIA0KPiAtCXJldCA9IGR3YzNfcWNvbV9jbGtfaW5pdChxY29tLCBv
Zl9jbGtfZ2V0X3BhcmVudF9jb3VudChucCkpOw0KPiArCXJldCA9IGR3YzNfcWNvbV9jbGtfaW5p
dChxY29tKTsNCj4gIAlpZiAocmV0KSB7DQo+ICAJCWRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJm
YWlsZWQgdG8gZ2V0IGNsb2Nrc1xuIik7DQo+ICAJCWdvdG8gcmVzZXRfYXNzZXJ0Ow0KPiAtLSAN
Cj4gMi41My4wDQo+IA0KDQpJIGRvbid0IHNlZSBob3cgdGhpcyBpcyBiZXR0ZXIgdGhhbiBiZWZv
cmUsIGVzcGVjaWFsbHkgd2hlbiBpdCdzDQpkZXZpYXRpbmcgZnJvbSB0aGUgbmV3IGR3YzMtcWNv
bSBsb2dpYy4gUGxlYXNlIHJldmlldyB0aGUgZHdjMy1xY29tDQppbnN0ZWFkIGJlZm9yZSBtYWtp
bmcgY2hhbmdlcyB0byB0aGUgbGVnYWN5IGRyaXZlci4gSSBwcmVmZXIgbmV3DQpkZXZlbG9wbWVu
dCB0byBiZSBkb25lIGluIHRoZSBuZXcgZHdjMy1xY29tIGRyaXZlci4NCg0KVGhhbmtzLA0KVGhp
bmg=
