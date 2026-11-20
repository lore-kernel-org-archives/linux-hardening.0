Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178816;
	b=KFUidtDOxM5xzlQPRR06ULiXOItOyQP45UQSFjZYDiDEnJsz1CAi+ncjmqHV2x0KGnZF
	 8aaHPDNm221uHib8Yx3NXw6vGk6zS/msFeKrNYJN0WH6IIUbau9UEIMu5dpXCmqZDvz9H
	 1C+nhwttKBz+Ca61wZt/OgsimvMYtu6Uauz5Ic5EpBjznmtAh7e1GfpDw3Cyettj0itOI
	 PW5iHlsCt443iCOThxibIu3eWCK7D2aDpdYjjNDQhSiMEa1Qq3GEYq65+XtLJhcNghsIu
	 x9kEBVUdeLyoZSFmf+aK3+vT8gOVfwha4NNtulfiDRWUuBe4ZXglzSZ8CHegPprHvBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
	b=webV6DJzIjnTl0oLtKFn1NOFfeHsAG6woUo1z8u91TtGNODRNL0Uj7EIBTZdpylvyQR1
	 alPc+p7ApyuGvLjbwhO5iR5YkYiGMh70Gm4GtnCKwFGKyQ271aDbiQANqUf32MIMpJRGg
	 GAMSfOrhDDI2Cft4kx57gHEvrBEZxVt3Q4ietRvDU4wSvDzMlWZwvPOKkhiUX31bd+1mI
	 WJCNpoBGzn2zlrmjrb3ZDbUku1+LrfqmBfL5ph1dFSkVNGenAksSjX2p0lBaacg8qAahY
	 RYXkBV2aEbJcgWdLMFni29mzsy5tgAVMotzrkTLDWiYEDVcP8lqI/9K+g+W4d0Pzswg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R0QGU5oF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSzLGaS0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1A60A2600
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD1A60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R0QGU5oF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iSzLGaS0
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjrI03731069
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=; b=R0QGU5oFbZc24jaz
	K8JeAKp+DafQwKeQBoxLJHy9NZenThm3sYRNunrFmfHhNflJkG57Pc06Y0tXT3KB
	SqZxq+4s300d9D/djek7paTjIddyIBOvH+j4ldJnws3F0Dk0fC2OTq2fJ3CHsSHH
	BS2PivKuvPe/co8DBU0MghGe5/XjX6WZ0YFBb15T2mw2TWvuFKIsRZDZRYSMG8TN
	Q1tcme8/mDF6IGuHndSuVJaleqI2nkQ0ZWOmi4EzT9KR6kQcogvd9WhIS3t/KNWC
	YT7U6d4J6Aa6JrrGb1U/Pr4Hgk/duzmLevKcsBkat4fZdSNAoaYDya0g5kKZIXtn
	iXQTMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4gft3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 12:46:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-947a607ec40so95162585a.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178814; x=1795783614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=iSzLGaS0fMC2twSJZ6CHEvYwjXiIf0FMXWhLNiLgJ8Tbk+te1FE7nMPlqoZA0+zrFc
         Z0mMLMFfxF4W/FvqfOdar9BJPTyOK6/Ek3Wx/oSWHiIzWz3Arkd4E4xcm7jIcvhFH7VL
         L14v82dZ7Ag34vyMugl4pDsM+WvxUXeGFBLf3biCXkpXEq0U8pIOUYKv/6MdbA1OA1vY
         sMw9Qo1pJbp5f1xIxwA2JkUjG9DL+vfcBFKqUiEuWMO5cHx04PaFg/AGZnAwIGMAbjFn
         Z79U0Pm+NSpB3NMYHOYkeggFCm9O/d7c/BfP9WTSGDW4PVq9aJdCa82w2YqLOglqKbwc
         U0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178814; x=1795783614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=05HkMf4ygIqtlQzRN7ZbpqVF0GJOazAPdTl6j41Coks=;
        b=Os2RejARfmLIl06xvfIEl9THe0XzmUTesj+Xl8d5jWT1fjE0EwCk48rrHTT3xTE1Ci
         lPKwNRluLkFkFTUQmgBhQ934Osrnusm8jMXdptmKejofvC0+LuysatsAn8NRcYjh0iLh
         g+StQrvhW9dsvVcZo9FAvON33VXvIVL2+ZpckxGVFiBKv3XPc0o3dQLunksM28SiiNo4
         RFw5+7G1/7P64pxEvfq8V1xhYQt6LLh0vlIKZ3NEYWz7i4svt/D82NrepKtBE12c/EDK
         g+SpBRFeyhbbeShS0eNXqNyQ/FyJ35MlK3JeyYkU/sXP+6Vp0LseOZ5RFf3U/DQcWAy5
         Garg==
X-Forwarded-Encrypted: i=1; AL+hErE7ja0HJdSyq3JohgfgWh5TKGhl4OUeLFaPHPI7igcVFHYS2TPPjeq/81Mzk5bhiT9JbmbbBGUbq3NOQQgOEFc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xNzHmI+Z8yenhPgDTg/N8KTcnG1LruKszV3rfUYhbBPiYKwdq
	bVLUlz6rQM/MdatGHU29oAZS11dT0EigcgauGdmcaYeRX3oI/D/jrD/cQv6EwhoGMiYfpwYzgtv
	+VUwTCA97IKT+H2hex9v5MRYWhsX5tSA8CwVNBtIV13u0awILfuKCfLCB9MtOqJXrwKgoyk8=
X-Gm-Gg: AYBFou3mX9Gr07Al6fmTSYRE0fklpDbdVkorenpxFqn/UHIhE39VLXXqivO1DeblUSk
	boM6PXvDKXMTd33Lo4BSoI+chZLpAa9RCwK0oTgcEedi7kND+ZeBowMZ+Ax0q+k7GiMuThL1li+
	pxZJsDwLCauvR7PNHh3Z3Lt/b5YOaqM8TBBywLJTiECLr0aVOChKfy3WIL+jsRW9mooh3bANjOq
	oQXDa/p7gx+iqVCQ4cMa4twNrAIiIA5eqUN5Ez1C7S+Acdb8iReqhBEvs2ybae5sOOYOcRzxxtS
	N3CKpP0zfKegjbfoqqcctUqZ7lToog00z6lRTnS4VcPHHStkhFl+yxKJkoZNVf5e6LpGoPZ/e0B
	7SN5hFV/RED9neR+9obQ8IGH8eBbMJK7crm4KsXH3ZpuOBzT3cKjVifQW384egNbQEA+t/GoZzx
	0=
X-Received: by 2002:a05:620a:4056:b0:949:7893:397d with SMTP id af79cd13be357-949ba9b8ccdmr519730385a.23.1795178813973;
        Fri, 20 Nov 2026 04:46:53 -0800 (PST)
X-Received: by 2002:a05:620a:4056:b0:949:7893:397d with SMTP id af79cd13be357-949ba9b8ccdmr519726085a.23.1795178813505;
        Fri, 20 Nov 2026 04:46:53 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm119248995e9.11.2026.11.20.04.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:46:52 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:46:38 +0100
Subject: [PATCH v3 01/10] lib: string_helpers: export and rename struct
 strarray
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
Message-Id: <20261120-fwnode-for-each-prop-v3-1-808e304dc73e@oss.qualcomm.com>
References: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
In-Reply-To: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hYScHpsRvvGBrMd1w71TLaQh4T+I7gIpjdQzKJBQdf0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrAEE29BUzYu7qXthMo1ziHpRFzdZUEh3WqC84F
 OGuKrX0zbyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawBBNgAKCRAFnS7L/zaE
 w34sD/9INMXQs1L2Mvsqvlku0UNIaFhS95oY+fgGh50hV8uPpZqYJ9NtZmpgskw0vpYis2Ro36u
 cztRSspCvn/1Jy3tnFXLHIbVPKIidV7uL/eo+pgDu2WooSCrpLxyVtDrCNZnyQY4rzglxSzgFmV
 20FtfdT647KzE+j63r3q2iadFYnTGomwGclZCfdpr3nExBli6ufhptbHBx2Q47EUvuQUGzvAV7k
 vyt4OFpD9PqxpFfoyXpBqT1Pgs9d8guOTsWXkbluTz0VOLA0sNtoMilnS0MvpxAe5azhLzRFSS7
 qrgJL5Vki0qb8jbx6YgCBxzPIf7Kmu6tQtg2hfjYCFsPj32pKplN7th3AJk8sj9qpLQIjomLZvw
 ZpTl8iJgw2H+oh6esb977jX6S5IxI7IiNqfg2zbHb308qdGmD7tw8z15idvvEDvyKO75tJHJ/79
 wkxPro8xFGpTImnweShdNOz9gkOVNue3adn56GhyY1nrWX3KyRYSzUskSGUEkAuFxpZkOAcMYWe
 SDGKXMcobp9/+IK83ILgxdB8ShLGcthKK1mx4mcAtYwMmbI3VBlmq2qBPyDJ8N6EyXkSnaNYB0i
 po/BVd4HrzPDYz4cPMbC/f4Ix9nHwFiCRJAYTkd89W28TI1EEtyp6D2bWlP3PDqIyCppC7jgWh/
 mWyRS+q1a+CyOKg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: O3_IfajrKFvtGpTslzR72E0n6XeKpmH1
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b00413e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=NBg0Ud2t-6tr7aH_vnkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX09Q/YOo5kf1q
 n+s0Z2ap7MTrNbkfxuAdh7tNsAxrRPaM2sJl3QiaJHkYQYB6TWJw4OoSxwpE2gL3DNWJ0mDPutr
 ZghAASbpKyw0vt6ixUkS0hF0rV1QTMY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXzFyQoRZyhpV7
 gf4cY+uo9q9vvne2Hd2BwpLxTcp/u+2K3j0bftx+kaEr3GIji6T1I46pxlGsJ03LYC5wvT07BSp
 QrgDcuhscQZUuq3HAyZTiLQaiyz90hjc5Mx5CMKEMC1COy6j8zPEfe2U3kUagmpMAj4GlQnPM5x
 7HiIL5gefdgyVht6Y0cSMMbacHaUVYCjLrEa1/O0SHigdszrzLpR4HBgfjExBqWIB2dHQtXL4cB
 7yLbnCw64gI0rlb3n3yzzSYHj8gHZrI+eD72i4lel4//HgqpfUG8p9KO8/hKpl12XPKMPOXgSi5
 wbwgHP1s0dZU5Mz/IZdy8d7jL3yaq29jLjeFPtbIxd0TLRGNxDFQDXLSbQrRyNeY4BNPnc+70HF
 CAkkGLLzt6di8C/xDyaTH/Pl7InCCUXu9BR1FOphW2fteqa54BEuX72niRyIlOYDpt9lCqa6PMG
 ICurRSXMQ3l18vm30TA==
X-Proofpoint-GUID: O3_IfajrKFvtGpTslzR72E0n6XeKpmH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200050

Ahead of introducing a CLASS() for string arrays, make the existing
struct strarray public in linux/string_helpers.h. Rename it to kstrarray
to avoid any potential conflicts in the future and make it clear, it's a
kernel type.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/string_helpers.h | 5 +++++
 lib/string_helpers.c           | 9 ++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 3fb88a1e989833ad5ea1a46858efa16e3971bf08..c9f08066439bdd33cc26e2054dbe1ba2e867aee7 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -116,6 +116,11 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
 
 char *kstrdup_and_replace(const char *src, char old, char new, gfp_t gfp);
 
+struct kstrarray {
+	char **array __counted_by_ptr(n);
+	size_t n;
+};
+
 char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n);
 void kfree_strarray(char **array, size_t n);
 
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 98d6ed0eaab7e9f3d54e420c404629a28b925bf4..8ec7ff6dac1212fe8a1f242654944ba6e5568e20 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -804,21 +804,16 @@ void kfree_strarray(char **array, size_t n)
 }
 EXPORT_SYMBOL_GPL(kfree_strarray);
 
-struct strarray {
-	char **array __counted_by_ptr(n);
-	size_t n;
-};
-
 static void devm_kfree_strarray(struct device *dev, void *res)
 {
-	struct strarray *array = res;
+	struct kstrarray *array = res;
 
 	kfree_strarray(array->array, array->n);
 }
 
 char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 {
-	struct strarray *ptr;
+	struct kstrarray *ptr;
 
 	ptr = devres_alloc(devm_kfree_strarray, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)

-- 
2.47.3

