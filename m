Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685791;
	b=icRF1hixN6DbgQa4TDwTbGNtLAnwcoUsb20j1QoA/8iGZUSb34wLoMnYYnAfP/yw1eZ/
	 WBcRrz04ikrVtLbnAmWW4cQNfJZqpcvuYfYMc85s3vun9+AaE4cvyb+6OXCIJ8J4jGRiF
	 tgJDCBJaKJckG9r2yTpyzd3VTuYPfP4lERQBRh0I5sNZm7o+Qge4Kme6wnYdxQ+Eebk8O
	 B169U2iNOQIfNbuHkfi/ABnPkqRaDglkRYn4rjz5EixVanE01nVTB3PdCbsx3Y5BNDrr2
	 CVigxd6G/Wu7OTuOCh4JvhrivdA0Ec3gsnUos3PCFkMaYX26Ac/FDQx/h207b5ws+qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685791;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=;
	b=vsEuwcEz0//skcZGdmZ5S/n4hPgSFEG2zvQgHjyNXDAVU7p8u937zZpiM4A+7tpJ0oi/
	 jYoTeWiFLL1NmaHkMd9emz7LyLh4EY0EIDAQTQ6Vc0I2hBBQjMHo6Hiu4aF0cPX0jBPuN
	 DcQZX1R2WD23tnz/3vVQdgmroJBaerpyFulR3dG2VkIA9Yzkz6Ae2ezzmkHl75x2W7otJ
	 t/SdjrBKK4xeACzzH+YirueNh4STebvR6UUk5TBtd/DKEMygRWxEewftJYA8JXvo9TMe3
	 j3StFpXd5haaJ+n33ZxXi8qCh7/twj8u7iOl2BQg4Ip0WbW9wmAvGNRoZR1CUwn76cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HvTU+1Lr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMZDCdq8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A025D606A698
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A025D606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HvTU+1Lr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMZDCdq8
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B8V0919527
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=; b=HvTU+1Lr0+TayoIV
	jjYxb6eyo99o+UgT/AVaicpY6fcDbW1BMaAX0d223RgCG3hu7zG9AVl6pJuaUzfy
	Eks6iYYvykbAa2pKrAnT6sHg4oGwjRknvKzaDP8pNRX1tuNpAFRhcbcWwkBU6m5/
	wbncP+VOqEGGJcwgS7ZZFH6WAa401chJSCR/I4qf1TDjTT4xmNYPjFoVTAxnCyoX
	k3iAh1KQl0yjEWlKbBQpp75dMJQin2AIa3TVJv7H14t3+3icXGyUAEGtcSJm0pSX
	kQ0WWtPX+r+owfwkZwxH/uyHiZtARvdH8Trx+pPCSIzMCaa7KXk56rJEYFFgbXRl
	mixz2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y2eyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so276532385a.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 01:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685789; x=1796290589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=;
        b=VMZDCdq8Jhiau+uf9VcKBg0uuapDL6IcC5y2d0p2II1nT0Lg1xcZwHL+Oe7E9++3Rx
         A1chdFopN+I0gOs1gbN20WdsHbR8Eu1IMmyrrZeH/IU925FxO4dMIYI9Z0bbqw6mAcCM
         EavIEhbs0qF5KgR0DuBdWxa+RWyJ7AQBcEF7MBHsG/rT6BTVV1w8p2s2COzSrOAFRLnd
         +rVMEnbgEiSRPbEyGwlEa0oR92ExmtXk8fABR64ZS2lidV4h0aB9hfWdKokQIvfi7ON2
         qzr9o7AubfEg/ndAqMf6p2M0BDs+D1wGjSQIM/xkEfQl5z8k8m6Mhi2WD9ZUlTo54ykT
         lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685789; x=1796290589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRIovGB/GYq3DzNOvm/z3TLZdByFS+QCwZOU22JFuqA=;
        b=cCoYBuScJjTRAxc9W4OBldxXvaLKXo0Lwehb2Uu3mavQOkyRy/0e0PQ8emk/Qo3elC
         p2pu9PP8w4tGzi4WqrRDUXP/HXPRq499TVCmCiwiyNUTmShshenh4vRMPBqNyQkpY/9M
         oEGY7hwbAnHenSrxs8vzq6m6bhxIRDIUln17ZNimYNgHFl+DKTzjQc5djU/CpB/jNVs5
         SZUKOAWjdckyp2UIFHhRr5AIJTnWEmvCpYXgklicmW0l+azZdSaG5stR88m0HCIdwnGs
         M/16bjveX4NfweeVECAbMNeGVOB4Ug2mSFfYXSbZzgpn3l9qtGi5OlXCODp+VKf4X/TR
         6HMQ==
X-Forwarded-Encrypted: i=1; AL+hErGut76lg3a5hUHCNWTdCxSo2jD8MEd0tJWK/Nc9TD6ANE4toRFktCyL244gAT6j52Gc92yY7BuCfqY+y8TfCSs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZTaMji2ZvlpykSZ5IftxMt0M5B09GCAaV+4O/yENp4yUZYo9k
	sAxsZGdJ/cx+y/juY43QkPbGvuWKlmSNdGcfVbPJhhKLfpaOprqq8dBpiIeNalwTMdOVD0dTSv9
	HB0F7htaj6i3+gdaSND+1PH/7JBN9erxujYlTLfUgrw2+4yOLgE/6qzTXVnrBfQdCH5U+IJ4=
X-Gm-Gg: AZFdTZcsdjmb0u4j0P1emsZZvEa7631YK4229niRACbzyv5j/6b4UF+DuiyXvvMhRGt
	9ptpGBQhXB5wO8nXpIEpUi+xid9tCZz+FFhlJC5WAvn17Eye/egwbJLPqrCH8LW40YJyh0FPxSJ
	3AI/u3YXgPsqEyObTqSErXXoCLVisGj38fDb4KKG9FcR0QRgl/oZ49iOzYX4VH1SYgXLB5s4Xk/
	xWae/prpURkPJ0hkiObM5XrBUzstj9us9wuVdEDX362D6P99sDy1Pfl7ghnE27fD7fxFOTZ7x5Z
	1EvvW8xykLBmVQvmNdlkhs4FBsZxjX67WPV3al0wB4vst+Urkhe+cfk1Iw03FnxtqC8a0z8cHdR
	jKuwcR/fTEJAQgiy4PbjwVjK+ne612SxOkp9XW2k3tgsVVhPtFnpRtPs0aLkRT9K3GhwQrgBsMH
	kBlQ==
X-Received: by 2002:a05:620a:2a0a:b0:93f:43a4:a47e with SMTP id af79cd13be357-949bab1dadamr3832610985a.43.1795685788806;
        Thu, 26 Nov 2026 01:36:28 -0800 (PST)
X-Received: by 2002:a05:620a:2a0a:b0:93f:43a4:a47e with SMTP id af79cd13be357-949bab1dadamr3832608285a.43.1795685788429;
        Thu, 26 Nov 2026 01:36:28 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:27 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:19 +0100
Subject: [PATCH v4 02/10] lib: string_helpers: implement a CLASS() for
 string arrays
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
Message-Id: <20261126-fwnode-for-each-prop-v4-2-d4b370ecfd52@oss.qualcomm.com>
References: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
In-Reply-To: <20261126-fwnode-for-each-prop-v4-0-d4b370ecfd52@oss.qualcomm.com>
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
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JgjwkDVUHWhy6uin4cUa0Wd2V5XuhJ8xnn7npsp7KAA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2UmlNPXMYUFj1OkyjJlNtUg+TUKM1XF8Nu7
 d7XYDXF1R2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9lAAKCRAFnS7L/zaE
 w8xCD/9IYhGx3cvDc9WQWKHuSblgrzMbds4fs/OJHOvppEcKmijm7eXlATdeZIwTvT3isiBUj4X
 vMkHZeEcEb3x5E6sPII4oL2sLrwLi6Sc0G687C90sYbHjuaF/cvPNwQ34R53OhVsSusUhpn8UHL
 ba9XnX808PqRAwtsHkPJei/FdYKzTAjyLVJTlIjXVh8ePI8zN6IjdXJRCSsPodY5I64A/swlRIx
 fpIfZWyra+oHPh/oY6PilA0cVcLLOLrKe/pvRKp6RxQaCenoPI3s+HYRsODp8vMD+YFabDJRoBF
 Ttfb9xQb8DiNf6sW9Vs6Hz4vwtoINt/h2jzIRwaRntNqP9wbgGcgdDZCMqoSXfX8XPLJ0eY401A
 SlgEgNSWLenIYKcrGhH25okc+JMMYO3oJ55c6yKNT4XbAxUTpMzsB7obKMj/c3dWzHJnQ9QoJ7h
 pqZ2qtHyWZ92+t7QLHW8TqRS7pvmu7vuvBeAJOSI4K3CkAzlm5XUE6Y6NOs72ti+GUvdN9Kj0KD
 DMwOqA0PUUR/Rz379B1UlFOzYoGhxCGxC7Kkwy90FcAsR9whZuHVEf6/oVrPLf6K244LKS7AlzP
 AC6jyUhZAuwrmwu0In9diKO6B6mIe7ozf7LbBcG5/Cl8f9QkcSYK6xla6At0MSFKKhgCB7waqvE
 xLx5I9axDKDlkjw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX/WvwGI0RcviT
 fQwiqi4STbI5d7OLoOrW4HqibxmkGmYQK7NIpgeHZ2wxHs+rsx17UUv035S5KZRJ1NjLpvKo/Kw
 t3CgvEHA4MUv1W9UXxAoW8vcTB7nCT9HLK9xA/TLO8iMlde9Ddnr/sk6YtPzpUH3ZvMHt9NaM3I
 rxDLuwbgu07Xd9/+l5xiS13M+DLCR+Vo6bsr5Lx1mvR3ThjkLkn5JZV4FgyJFzE85avnNmNb+XF
 mhp8aea8T1ymjUrbBt95NcM4tOKPOlL8ICHHgLfsENBQ6TANq60UvhsHWw0eE1mfovi35RclTDp
 ChvU1GFs/1QW+bAMxWIc83uNyTmOztlasHrj8Y6O6I0YF2t4GhCJK6xoa11BaEzZyGrYF5QVtbs
 i3YyGYzRJbxzaFRVwRK5IxmZq37keIMeZimDmE1xcJ1ex/lGV9WnDTt2KxJFzL1ARCSqR+qwq+h
 RzqLYqVQqW1cgjD3JHg==
X-Proofpoint-GUID: Ufetx3OXY9UxbEdheb1p5fCWIW02IM02
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX8KGaBYWMnX9H
 WBBbH/H8fds1jEOOr7GN5BoUnnTSkJCMsiX33gly564I7DLlMtNPOc25SgQNiEjr5rSFVdgCLFo
 pVrrlq/XHmCMBzzG3whh6VvLZcHsVQw=
X-Proofpoint-ORIG-GUID: Ufetx3OXY9UxbEdheb1p5fCWIW02IM02
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b07fd9d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=lR0QwHyGZrhmQDu0ocIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Provide a CLASS() for managed arrays of strings. It can be used for
automated release of temporary string arrays when they go out of scope.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index c9f08066439bdd33cc26e2054dbe1ba2e867aee7..4db73bc7d4623cf45954cc8794c5baff6fb23241 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -3,6 +3,7 @@
 #define _LINUX_STRING_HELPERS_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/ctype.h>
 #include <linux/string_choices.h>
 #include <linux/string.h>
@@ -124,6 +125,12 @@ struct kstrarray {
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
+DEFINE_CLASS(strarray,
+	     struct kstrarray,
+	     kfree_strarray(_T.array, _T.n),
+	     ((struct kstrarray){ .array = array, .n = size }),
+	     char **array, size_t size);
+
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n);
 
 #endif

-- 
2.47.3

