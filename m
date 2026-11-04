Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801080;
	b=MHlZ0RWMP7F1en4sorCY4ktgrbw4Iyso/uc/MvLCH7p0LNKypJmgSIE/THFf8oZXO2dI
	 A22aeIn2TjUKynDITs03HDG6B+dsKu13c4Lhassw2QZU8sB5BPZs7NBiRQHWIM+Gp16TO
	 a+W3KIkmdR3+48IcjXfVhzwbhRbxLl1pKba2kD+Otjoc7usoTM56hHIZyHZsHrmuf7XSN
	 Pd5aeRBp1+W9YzvrmX3OuSt6fdgxKcYdw2PiP28mdzk8Tm6QXiVSuyvICU191Skuf7Z0h
	 EdjrkZeldSct8Gtacuoav2r/ZYFy2FSHotMgo7+umr0UhQ6u8gER7W+9t5BIpRe/mBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801080;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=;
	b=znBRio+HzyOISzXlvehLg2PA5zeQQfHbRMeZrNk8LVHrVA/QB+3DgWNc8c4rcrvTsYCF
	 XOZqhiJMPIiCTzDh6InRaVnUe+8AbkVbsDyEXNr53jYDId4qf/Svr9PWlG5JUUvl305Ck
	 jiASNayVs4RHT8IOXwu1Q6+plr3VrwoLH2wY3Hc8GDakYIw2AtUcdyR/IxFRvdS8zaL95
	 u60/AfvUTHQrF83LWROpoQcG2yyg+5PXPyMUlNtu5/DCUTscp1kjBLGvd0hy88F43Z3iD
	 BeSw8Re88D5b68Ssw5WZPaRDAsffN5m7TmrVECGz26dfPADCoELJFw/bfWhgIQliO5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n6BlCfAp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FNBVzBwr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AF606EEBB
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 14:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C8AF606EEBB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n6BlCfAp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FNBVzBwr
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZxWi119409
	for <linux-hardening@vger.kernel.org>; Wed, 4 Nov 2026 14:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=; b=n6BlCfAplDkRIGJY
	OtZvEiHnmJxfVXUqgCmbQ3HY4qMos58f49uoPT2qpuxiyvNqXiZUg3EAZ5KwManW
	X/P1irYdeYwkWlRqhibdk0ToPW3KLNnTBRwQTibR6cnH0c2CL3909RF2qxFC5T4z
	MRmi9u6ZWWSk4u5RY207c56jDfI53aj3If+toqprwFx9Ltygiea/igBKX3yIXB1z
	2ASo1yVQ/7vqLDwKgTyjFS0FLODgtQOWhBH3BwSI9kvYT9eMd0/0Aucly+AJ/ijl
	ncAoe+ZbTi4hAD4DoJLZaXlEQGcrbpqC04GepOi+liW37GrSLDaBhRL1d4h7xKaf
	1U6CiQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb0aarh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 14:04:39 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eac74b0596so699668e0c.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 06:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801079; x=1794405879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=;
        b=FNBVzBwr5Eb+sunEkrrMbAMxiGeqG7gHOGie/IfGfCpeVE3ZhGad98zeCLNXdFaJPn
         amW3/Yghr27q3JjNywHl6JKYKCOsbq8Q16UYhPSorkkABdHnfc0K8O4kc9lKrXOPV+Wg
         8fSSXK+4LK/k55G0qjXqmIej9eA5n70tI4+cryavy6ltVQXe6Uwpxx865FhpvdBmSyeG
         vPVeR5VXBz5XoZ834RBWp7CQwiQcT4ekr3gtpvsyu0GSrY+y2jN9pTXJJK4GHiGQh6rV
         179HSGDLWGQJz+YgujbFs0f3vUYEUHpN52bYvYKpVLA3nfdJjQPgIgWcZjPP62icrw36
         Y04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801079; x=1794405879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RA2CSJdL7Exblpp4WzRIxFOf+cFemPFyxHbTRFzm9pI=;
        b=rnEXown/fKE6FUHpWeoBy9a72CsWPFILt595AzN35waWjKscxsznM1sElhC7MHZSFS
         Bcvlzg96jRGCrJ83fdxKufY15nI5Jbyse/LnWno2KyxCPerfMj6Dmk2wDZJ6gUqkhzcj
         Tz9J2xxWpX6KEyyFpuX5QySUWR9jgh58KzBnrDM3a5/tIfjDDqoSfjkwJazeRSITs+fG
         fh0MpModyBF1al8d98TRlSFAtps5vMH4woIwOKDbeGHK3NXkW3egX9JeUDKX1TJ/x5EA
         R24WW8PCUTOyXriqdTDtjASInrPJtHyTjgda+knrxDsRnJNELoYfskj8Gj17hyYIodib
         4Qbw==
X-Forwarded-Encrypted: i=1; AKwUvBxbI/LDoBOKuhSIPIxM/gI8mE/SBl2ZqRSxEgLjoAN/QIWh4wTqnYbKLr96orTMofZtSxNONdlU4SgehLskHjE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VAhyJBN6jGiDf8/dIk5Na3VHljspaoTAB0gD06MWr/42XYjCY
	bKJXq1SM7FPfPjagl1yQlalNFTXaYJIx/O0Pz1sICgnGoSQm8nGWaIkUJH2N1OLWzEctgQYIn0M
	SN1d8A4HQsCqqv47FoV+Dzj/hrrPlgYhY6w2RMCVu7pPGEguG3rWa5ffBRHpQMAUAldmkeWM=
X-Gm-Gg: AYBFou2Hb48g2Dm5anwqeVvVtaN4Qh0Duf4BxSs6OHYyFvuOK4654Q/dkTQp1F5xZEL
	sTkWe1feNBv/D+1RJ5ds7ruaAzSaBU7gDvC3QLFXPrxwB5M4zV7+J0INoMaYAIRcyyox3DV43Iq
	vbB6Ba1P4R8hEhFWdIKbdq0AsbE9Kn4+vudgUm3LmcFZ/BN9J2AQSGvdFBueUlv9dEq8IfpOA0R
	dGE1Stpa+snAEBo7mV6xBuG4h0a1YS+RCwQj58HxXT2tbGwzsBXUbOPfxqwZRfZlZjmd4/ROSkM
	zL1+wLreGNdfuB4xDfSE07qKgaIDH1qUvz0Omayg0xTXka02uVZofsDVdPoxzAyibk7U8JAri1V
	qy2Ju3MEFhG7ierwgrxNwBnJEZk1Pe7jGBOkAtEIkZqlvDm8se199bpttYdDlKR8=
X-Received: by 2002:a05:6122:c89:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ec689f696dmr7593964e0c.20.1793801078090;
        Wed, 04 Nov 2026 06:04:38 -0800 (PST)
X-Received: by 2002:a05:6122:c89:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ec689f696dmr7593898e0c.20.1793801077646;
        Wed, 04 Nov 2026 06:04:37 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:35 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:50 +0100
Subject: [PATCH 8/9] of: property: implement the count_references() fwnode
 operation
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-fwnode-for-each-prop-v1-8-6e28fe1c72c4@oss.qualcomm.com>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
In-Reply-To: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jfcJL94RVspgN8CyK/snZo0rp9b0uidqlV9W3mfnsrY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSrVGZJPcf5ImbusE8w0YzObuzDwHNwk2vf
 XWwfHOBNamJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 w2USD/9+/oAE3ozJ0woCpNJfEKxkKc6OkP+Fp13bf7ApUWvG71blBdfNz430uIpxhii9lx9NSHF
 H5yKot93opIVe4f8X7I07vIwVAQBfP1dtTdnVWavMAELyhSWVOIQX2Lp3EFd4Rtky9afjzaw5CJ
 n2zulXoabInrDbALeCiYXy7xfflbtsynqdIjm6SLgnLpb4SURUSTbySU1yoF6hIZLyU9GmQ+Zm/
 A5D4lBHWrYNUZL0OIcWQvWX2Rq/S98QJJAzublBzvLUImTHuwL2SuDBQA/qMIjc8oKlukqHP+/l
 QGKLXZ/T5ru2K9z8VOZXMD6tyZBzMrVvhZSIBS3UqsgNlS5FSNVGiBR5bWprnwdgXI59W5smAKT
 toEgXdyTdb5o5ZUIziSIfpQabmoln4rKHRISWIGZQ8WuqucOi1iVa2XCEQKsUkLiy82wmALNRKD
 uPDnmLZQVGnDdSWcMrHPAQ/qWTFNV4K1lClnzSLHITbCd5uM4piou2+lxdYgbR9X36K5wP2jxS4
 areuRfuUDSYwSS/3EZBlTtUolLcKcPFlfrgY+TPvIuh8EPLSKz5Dc+BGF15ed3UqLsy8M2yU5GU
 GxstGJJLPGB+wYvlupd0Y9JXoZFvF0wuLIWD1XqR7FCCgW3to2+DXgWre+0LHZF5xUFVpyD9SjA
 YNWIV37TclMW99Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX4drRDpMEedVS
 rwH4SNCpVyUEB/zB36O4t4/u0GKzjjYHBxZcrIUfeyfd5UOIsias9gExqcj072DrpkC8biFNLKH
 7wy0nFt13+QmRBLtJTlimq2Q9L7Z7jE=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeb3b77 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=zSBz9IY8uK3Zdpgw7pcA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: y8UKM4dZWo_8umoY4VWNU1znzMt5TBlH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfXyoRCOAegdwA4
 azfVugDwN9WTYJolXOCRZrAcgYc3k5wYehe90c2z60M0+OCcIfRKjv10JQATy/g/utqGsxkTU5q
 dfwqj0EhyDKlfRDGefuVqWiWHypux7QEEGD6dOKhaS097DC1/pFxwVPeSap2DhwKMjM3ZAk4Vow
 02sc1liMNQGR9Isa4k9tffRjIAwXB/APhcdOVfR6AY2XaGBrLWO+DZK1ZHc4trfRMdt292JHO+Y
 IAJjd6qh29J2DPpOzB0f0XBafk/IwQat8Lpcb3RRQ5dROYBzyYd+vDpB09Q07LBbyxMrEeKAPMd
 3uCxLhmNsb/C9qrAGuMC6Ua+hOrahOiYXoNmBVCrF7IMC5HXKuVMerrfb4sYy10jFqbx0ND5MGR
 IZ1tlNyyi/SKqnmWszzOGGCw6IFydgiyCw6vSBvYBTQ0+s2vr8B7HXyS1oXx11bs1x6jR4boEJm
 I36NTghz6YfwaUDLwsg==
X-Proofpoint-ORIG-GUID: y8UKM4dZWo_8umoY4VWNU1znzMt5TBlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040056

Implement the property_count_references() fwnode operation for OF nodes
by wrapping the existing of_count_phandle_with_args().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 16c9c307633bdc7c9343782b1cd3bdb845552c6a..ae2561479e2382b241fd87dcddf52dc7f52a950e 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1231,6 +1231,12 @@ of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static int of_fwnode_count_references(const struct fwnode_handle *fwnode,
+				      const char *prop, const char *nargs_prop)
+{
+	return of_count_phandle_with_args(to_of_node(fwnode), prop, nargs_prop);
+}
+
 static struct fwnode_handle *
 of_fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 				  struct fwnode_handle *prev)
@@ -1747,6 +1753,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.count_references = of_fwnode_count_references,
 	.get_reference_args = of_fwnode_get_reference_args,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,

-- 
2.47.3

