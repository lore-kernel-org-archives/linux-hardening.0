Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685800;
	b=i7mkb/Nmd6Ki611l6LlHL9H7c67GmJvl4D3UeoLscFAB6bpNEGZgk7rK6s4FGKyhKhmD
	 QVjvOXMpCF7sn7ZiDvLYsXVZ6rjTs7A4++Ig3BFaf2tTwBV8y7+u2SJc/xh8vmXZL3Frm
	 Edbq0kDXJLnE8jG3gln2FG5vTrTQkSBJeBkNMyRTJfHOwDVO35EY5vRdtCtZC/FIZSvPe
	 khZkqlAH5yThlT69nUTrmWBcRACn3PhuPO8AGmjjJyJiPvH06rfvZQnVjG3bzwss5M98y
	 9+qTT8Vu8vUiqT5Oc5x5KVYDpejpTorIMewDQLtbAYVvW2KpiR6bV9leFh2VJMV/62A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685800;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
	b=ynWI6TQRI0/vl2cLM6oL/hDcOtmtFCI0OIBKnENHeXSQAhVJNTV4qe5L4KueDVNjcE4Q
	 bFKSJOhKyqU5WvQO9/39bifzRT7+rlh7Qjhto4ijKESpFDIPSDqBlaA4ZbmM6casGRIT2
	 VG8ZBVy0PcCgQMRfq0XAul51ZZZlb2JPZl56GygFJUSa8cB0Fe47QalF6jCBLtVEtc0Cc
	 NY00M2NpyCRpcEvOS6tSdCNJuF17IlGJPvXoEiphwa3/qYN5G0eTV1+G3ouRlHT6p21f/
	 j/dtG36V4AwgFQhwdRpvS9CKbAEX7waEIOljxn5CjDz/Qssr3+XSLOrC3Gn35P42l/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dMy6Z7LM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SopBH1nE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995A606A33B
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6995A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dMy6Z7LM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SopBH1nE
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7B7Ea919512
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=; b=dMy6Z7LMWwf5pGPS
	2AZDGdNSbEwYP5I+l/u+WYa/K+2b+NATEAdkvID55tbjesDfb/Vh9ivf1fkK60uz
	ZiOfh0NSJuoh9L5qrNZ4sog0LDFeB35YDjoDkzds3ZfscSLV+W8RE+ShKgB0+7x7
	9Cc7yeOJF6neNT+4s6w52qh6oeUnWo9H+JxLUSBIt2EJmygnK3DOOH5aVAkRJxpX
	R01paHjxLpYs38GU17uT2h7UvBz+2rkdiahWwX/U93IRdvKZfMPAyjCdeboUFe9e
	ukIHNw4JQcZ/eM38akhROmuBhLLdTuB5VJY9bmJd09+YpKQMbhUac+XWWgl4mTYA
	cub1ZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y2f0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:36:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9495dd0f07eso1175538585a.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795685798; x=1796290598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
        b=SopBH1nE9sO7bBXQufnn3BAw5PcbewX8V+1taIN+/0We9K6Yv3/QQsiPmBIa0AbPhW
         O4Mf54um5v2av62hnLu332q9usw8GJLYYoB7FWZP8ZgRIdMTD/ZczDp3M+viIf5WYIcA
         4IjgLy5vRw12gd3R2xhKLCYMWOJFVU5AWGP4vuBhnpvYcoYhGiT62ez1OBwF/VHk17IV
         2LGO/URmcDLYdjZI0FM06b0bbZz7JWUAtEZcvGNkS4BzMi03VmZlcrE6u5Xt6RKPEVtD
         VkOBRbwzc6Qp768Mab8O1dkvvRDytgFYwwKkp5ropjJz6+oBunM4lpqIYlB8yWUPQioZ
         SXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685798; x=1796290598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itd8Y+uchN2HJrYq4RSPlfZt/iDxc9zWsOFSO8a/jcY=;
        b=nV6oIrPl1AJjAFXAJZZME+OoiTvTBsF6+GN1hw+OTJ5cyfXoYKPKUdejQdmhCBffT+
         vYMGzff+WZTqQ180caNaL/MPKNj7IXrC4a4EWbNZfsR3j07EAYXn+M7ePZxliy1s1rVi
         LaghjEPib0WmmZw2oA8MXX4Xo2Aje28vMxTBaoClBV18BeFZfJpzUZl45HYVjiGSge9N
         NYono6V3i4cPhComT625ych48cLJoNnhI3CuhdpwRRUAvpKcVIpPbsn1a5kRNVq3Iy5j
         oc7e40kcoUT6yPMRRe9v3weT3X4hp4UbbwmVqYtVfQ5raiL5rowiMuYHdzpx1Y9LQQ/n
         UNvw==
X-Forwarded-Encrypted: i=1; AL+hErGk80FBJ/L09/+vatmRyXkVjv3vlENtUDUcSAldvaZ2vSB1/Tog0H/v4uTLq2uCqEVWXVKg61AzZPf24V8W9Kk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tpq7uzQy7O49NkDwUvbZ+1r2rotthcn39V9bQs3d+mNTXwwlR
	5SS5/l4luIXmV2uu3+OH8zAIMjA/lwxpmdhr8bnDUZ+atMYmtNGD4REGGD4A24+Ni4YQUI+ODuH
	X3sBgtUZaZJnDPSP8RY9u9tnUAVAMNBHhOXo/YWPOi05z1lS5pUBIDuHn6pemdt4z7AeE74A=
X-Gm-Gg: AZFdTZfDVZ2H7ZPpWyCczTKm/0KYL/9ecZC32U0zohDIxjGa9kC6yX4yQMsNUMiLUAl
	7COxX26UCzTcOKq2MaBHiPsOakHKqafmtEG3URYyG1qtcHYFQuZbQLbmipe0JB+1k0ew5ujBHLv
	mGIwX3yKm+pk0/ByWPNHHy4CoUmgAnNt5Cb+Wy79Sud7znNifK4COsam2kx8XS/jXX5dM9Lgmcr
	KVXhCWY/5OyaJHCuq4Q2sB3gI4idR7NNSO+5zkSzQ9UEyTFr440M/TT5BeK2rOtHbm3+5vjKUGM
	Y2H3OtkSKN4wRbIVUwAos9WPZIGoDvvmZY7Tj5/91fPnWhW1GFL9eptE7vdMh046h1kT7GHWcDF
	24cf4F/jbGtEgmRelTNa10uaSFTOnyPOQGtkUiYSHOKw2P13ddNPQsh19EmD9bL+3DmfRb9zI7f
	pEqA==
X-Received: by 2002:a05:620a:45a2:b0:949:721a:184e with SMTP id af79cd13be357-949ba9cd23bmr3593388385a.36.1795685798526;
        Thu, 26 Nov 2026 01:36:38 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:949:721a:184e with SMTP id af79cd13be357-949ba9cd23bmr3593386085a.36.1795685798129;
        Thu, 26 Nov 2026 01:36:38 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm227079335e9.4.2026.11.26.01.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:36:37 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:36:23 +0100
Subject: [PATCH v4 06/10] fwnode: define the count_references() fwnode
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
Message-Id: <20261126-fwnode-for-each-prop-v4-6-d4b370ecfd52@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uLLErtVyyBCCkNg/MASZUF+mZGiOHH8LUrLC/RKjXs4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrB/2U49UIjunv1TUDqXQxjp7bPV2Mn8id84Kjb
 YrUZdyxJnSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawf9lAAKCRAFnS7L/zaE
 w3CpD/9JCHjjxCL5P+FTpe8F2GGiawr3+FVB3NPlSOloMozb1b7V8YXdCjdR1vtoY5la/byNl5H
 D3m4zYV7rlupbToFkuogWz1vb7oGxeyH5t1/4jjU+X+1YBfeLYnW79JPGe+hEVDrq/HMRuJ5mG/
 XeVugSGOznf5XYmyk1XQQJy6djgaGAUmFv0wzzMk5JQQIJVZg++75XfCNnmQb4Jiu1fT4IZNESC
 vsYOwOqolSWhaauDQR2OLx3TTF8ZgViTLFYQ83kQfUkzHpaWTqP1KB0lPl1HW2EodNCDImALT++
 Ie0rIgLExP+blKqJpbyrPmKV4q2EE9pGTrVvQc6wo2IFFLoegext0vrgevpz8WW032VHCkLLkFd
 8nRXwJ+L1uGpuFuNs7ubaE8fgkAvRs+YIzdS70rxIPj2GhVlMkO3kZsk9uCtx75e1+eVTdPBtzd
 0RNZw9i+WHWdI2YEKUWb40peNv3F7jBxJhNYn32e1TxxbNtIK6BJjLOzDVg4fn6R2gW2BKaVaTb
 J4xlE1FiAfsA4vPH/3qWXETHEJwF4sRZWVGYPQlz27ngasIq/NSgGrISDP/xy8d26Guhxf4Dlbi
 X1n/RvSFXGz+63lB8gxMdUIWBm0lCCTSlshoe+XRIYMaAnwtonNdEwgUOobhN5KpKDVUij8UgWF
 bJAT3U7BA/wMT2Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX6Y1Tj74pIQBP
 S9xzPuU2qZVoLlTv69gxV393AhL5bcK2g3xMxBA0Kxd7BYOGY8hdqoBS9h7/KcSrw49w1ajI1lO
 ttCm9nuPIkFYRjYxrk90ECvCeke3bG+A9b8tqMxDb4QtG+27UlH0ZQ0+fO2ziV9JMWdBFxQ09id
 UGUBmhkS/0VEeUBxrGsBEOL2X3pCp6hSKFHTGXrAsVirsf7uzkuRj4u7hiM+YPentl3+8On2HMo
 Q0KqgyJtMrGd/4YazcPKwlfEhdykNFz7R0zFMJBnk8gbYWVCyFaBqzheSDXNQhA04eWEYZr/ThP
 MmsRZlcnPTHhA/LaEiN3U9Gr9Lzuhzhv/M27sptKrs0sNkUL9XM6O5fNBNie37TgvP+ko1Z2Pue
 /TLIQAigjQYIBiDO9QTnUqRs7Qz6YQVZT1z9EoJyAZgBe/yNivuuWKmKUl/KCnP4lQ8CfVMrU3y
 B7lR/4olXVVfQDHYUiA==
X-Proofpoint-GUID: jQi2eqDat2IBEJXrh2G4nlo7-nmC73yT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNyBTYWx0ZWRfX6uL9J0xu7/iY
 SIlsUamLarkA9/S52qhzfzwzRj0HPSm6QbzYKjX9GuYZmAGGWKzXrM8KUd7s4rU5vqlk7HNLSIo
 HqvnrM9yuS5UV59dlk2qvA2KDlgZGcI=
X-Proofpoint-ORIG-GUID: jQi2eqDat2IBEJXrh2G4nlo7-nmC73yT
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b07fda7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=pu8Hlg4PHyDR7New1bsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260037

Add a new fwnode callback allowing to count all references of given
firmware node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2d7e0b9245d445d473c7317bd27058abe5750b40..15acade60564ddb5f5a48f2235b626466d77dbdf 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -137,6 +137,10 @@ struct fwnode_reference_args {
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
+ * @count_references: Return the number of references in a property, including
+ *		      empty ones. @nargs_prop names the property in the
+ *		      referenced node holding the number of arguments, if NULL
+ *		      the references have no arguments.
  * @get_reference_args: Return a reference pointed to by a property, with args
  * @graph_get_next_endpoint: Return an endpoint node in an iteration.
  * @graph_get_remote_endpoint: Return the remote endpoint node of a local
@@ -180,6 +184,8 @@ struct fwnode_operations {
 	struct fwnode_handle *
 	(*get_named_child_node)(const struct fwnode_handle *fwnode,
 				const char *name);
+	int (*count_references)(const struct fwnode_handle *fwnode,
+				const char *prop, const char *nargs_prop);
 	int (*get_reference_args)(const struct fwnode_handle *fwnode,
 				  const char *prop, const char *nargs_prop,
 				  unsigned int nargs, unsigned int index,

-- 
2.47.3

