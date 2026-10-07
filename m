Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3714AF165
	for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2026 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390523; cv=none; b=LkeQXEIYzPv0+su+dl3O4EzRofY7AHmJN2PDRsqWAb5vC0LmQ9+gAtinntHkLj7Jtvg4Zf/vN/q69oHluIrW4tipRavvaaQZO5JzZO+0foCm+k02NPdfXVpwzz36tBDWgaddRQTzwL+OJgYdRUYah7G5VIvGByrWMQI5qCZQz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390523; c=relaxed/simple;
	bh=259dEDaWlzVpxlGUwhq/AX7U3geSOV8jkOQL+05Kdks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G54hBbufg5SJA5a0GQSjXVWkywaferPEuiFcFkYUuJm675stRFH9earEdpk+FVWOJEy6jkwLfgxF8s4E5BNOILq1T0qzAwP3aF/qk4qcYd5X3vPXNYVVwLaNKYsjtMRjdX3dg+/qlGiqT7Dw4/1/p4K0YZgrjedJGUSzX+6GJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fkMdRjwf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NSTLhUdT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fkMdRjwf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSTLhUdT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697EtR7c072520
	for <linux-hardening@vger.kernel.org>; Wed, 7 Oct 2026 16:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hCX9hHQJ6nF+kufyd4tevz
	lH5RbSugP5//mR07T9oPY=; b=fkMdRjwfpC3UYuSLGOPnswa/VTjmHuVP2RP3tk
	Qaq365z8MwvdZjjouLDxNtU2IVBZjuSmUxvauu1a3eDeWwm8s1c2DU0gIGZ5blfg
	5/evQSKWZrc+Zh2ufid8Fi1bm4uwQtKcfNBmh0wr+sN9IrEAFBFMS2YVZsTiGQ32
	bt/IFnF9DxzlagvhMj1KxggOHj0A13/B0om79VVIkL3enykO7Gu1P8LZzp0Pe0+Z
	SVw2b/OQMw+cpcQg7i/kQ4m9Mnnv/JDeDgkFv66kWqVIuf6MUWu1ANe9mMTsr4I0
	M4mLaP+rj5VtIapW2ENHNd+uNs1aQM5dFZuLpz+KC+PMlaqg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5pv70rbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2026 16:28:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc40759b2so864070285a.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2026 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791390520; x=1791995320; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hCX9hHQJ6nF+kufyd4tevzlH5RbSugP5//mR07T9oPY=;
        b=NSTLhUdTCa2evXkHNjZ3kAzkw3DnLADM4+DsOtmuFyPDCQ9M1+dO9oNr5RFF5K5QaC
         /R16PbqUlobZD8rWm5yN3Z/FPI845mjB4KSEpe4HE3B2hDa2LSd3258LyAbHngn5cNEZ
         FXH/IAdgMngyQc7Th/JVxsVQ1exCxc2xgrcNe8Ihp9a7Ie9HCIqYloRaTmpCw0Bp9vJw
         GjtOm2JWP7dUrEt2Y5kDkIVAo4wjKFbSijmAxcTUzFR7qus53puzcC5tjRqmxgaa/Erv
         534RE3lCYSUVd0rwAnaI1mlEYaOg+bsgmb44y/Dmb+jcTdGYDPrTjy+6CqpO3HW2wZS5
         HbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390520; x=1791995320;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hCX9hHQJ6nF+kufyd4tevzlH5RbSugP5//mR07T9oPY=;
        b=mJJQL8Ts2fBiHFVGab76XQWFw6gh5TEX1mGucejQwLA47PUS0WvpsKHYdd3Odj94N/
         K8c9Z0+E18r0JltVC8iRBd+mn+8Z+ewvZswGt1w5C5aLxEOIosfpm+pKGMrNsOuVYu1v
         nEWMIBiX/4QfC02Yo+NJyNj14fPg9UPxCMrej5v5wwJiFa2gptCXKQiDKn44NSOac31r
         0u4jWwe6zdtQMDi3hAwY+mhQP//ZLUA0pxmo1f9q07RhrA3FM6b/MmkSt28GszCpLo0a
         DizfHphCLeGTEbjgCPZEkLuN7mz59yhqgq4xl9zsrAUkAFVQIyZSVTkpowTMXYFoV0jY
         J7JQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJYCD83gqa5SI8zNAYYXcwG+VFi+vfwAz1fPRwBVAJ2a37vesipEtMmN/TIJjCKyBNs7KPy5cl9MBWUe4miHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kJtWwO5F4KAg+/qPkwKWG5Uylj/gUspY0ZaQcZcqUdf6jwVDug
	550d576CjZ2sTSbp9d48zLIFCw0nuiem90F0gZJeLv9NxsqFjlzET5I+7cYCeXJkrH37WTHggYL
	mWi1GwwZ5nQtL7ixDMFDbDs/OeokBZJ0d/5ZMLMQVIqPKDqrmunwVLMRz1XEhRlPSRP2npW4=
X-Gm-Gg: AYBFou07scXSq6nUeDKFoEgyiZVYEYrcKpyb6eSzoQKmxy/kYAbMzwt1haxlRsDqlA0
	08sShpHQHm3lDOJuWMzxj/fdnA71VIjQjRU8wvyYt7A/82IbeOZG43+LEW+lR9DqoQaC2kjQl0F
	Yi7vv/IGlCKBD23ec3LKprZtWHkhdQvI57mno9i70QvSKChzk153mmu3b037vMWsBVxDzbSZU0k
	Pgj3Uw2dic2sNgLc+sfym379ASoHbZKGksiStl0YDtV71+/tgX8aXhopWkFN04a0lW3DdnTJila
	/l/7y14PQJMmLfm/PKMu7JNuxOHf/MzwTNDvik2lBGgvZQ8n3PdK0DL9aRr+tYOddk8UBSb6kCv
	NIAzhENF/
X-Received: by 2002:a05:620a:40d0:b0:93e:9808:8d6c with SMTP id af79cd13be357-93e9b84ae41mr560207585a.70.1791390520021;
        Wed, 07 Oct 2026 09:28:40 -0700 (PDT)
X-Received: by 2002:a05:620a:40d0:b0:93e:9808:8d6c with SMTP id af79cd13be357-93e9b84ae41mr560199185a.70.1791390519216;
        Wed, 07 Oct 2026 09:28:39 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1808d7b52sm31287335e9.2.2026.10.07.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:28:38 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 19:28:30 +0300
Subject: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAC1zxmoC/yXNQQ6CMBCF4auQWTtJCwjGqxgXZTrVUZySFo2Ec
 HerLr/k5X8rZE7CGY7VColfkiVqgd1VQFenF0bxxVCburPG9Di0ODr1Y6Q7Bnmjjw8niiGmWcK
 Ck1Mh3FvTdH04UOAGSmpKXLa/m9P57/wcbkzztw3b9gGgTO8BiAAAAA==
X-Change-ID: 20261007-b4-landlock-fix-domain-fortify-panic-510367f8cfe3
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Tingmao Wang <m@maowtm.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=4354;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=259dEDaWlzVpxlGUwhq/AX7U3geSOV8jkOQL+05Kdks=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqxnM0C+OtPHm6Hpq+j4X601QkIY0ort0v/b2SZ
 Yk7SSXStK+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCasZzNAAKCRAbX0TJAJUV
 Vv/DD/9jLnB7edsEAPmktBD3LG4PNnZej8sYtwv9KDIUwpja4mHRfdJ44CR/UW6KisAoajD0oWF
 G4UQPgNtZ2Y/V7+vkLu2OtUHT+8W7b1TByK4Ov2meje8FiSVZlky1HH42RWuWVjeWLpWHhbcp2O
 Qj/lcrzYIRg+W5b42GW5sPG9N3L5SnONDebop99Sh4LsatctVmUcHFl33cwRwoggPgeELJwzfjD
 8LDjR+d5uetFCAyJAh0HjzFBebmuc+AiRzKSzfHOHTm91y5e0PuVsM4VneWlbNUJu0L3ARriJWl
 nR8Bdc7LA+SzYMBeEI4V9Bt1SnSv05tzuV6R64/+alZ1YS6NKab56og/9YTh8hCV8jo4Gs6kPMf
 M0mrUAb5xJUU0dqOXIN0vDGqAopZrTfdidPWBRJcfDAIqC6BDapVJaL1wd7ATZE1LxT3pYtFtot
 w1gNOZHSaoC+SXqI7wClx92Lr9KbxE7o3wj4zWrlAjCJFdSM7RdfB2ss+rR2N4qrHyWR6V3ZmJ2
 yRu56xlPaRC6fOsuBSnwkq3GMrw+QEqAVgffDepl9qS7OVJRBpk+f8NyT1FFF2WdocnwMRE9gQP
 yn9IGqjMM2wFPJHfN/zyT5EHIyi4HqVcqRm+FrMtWP8zdZdg5jXyqD4LiHxHeuRLLOojE1AnuYS
 rzb3ttm71tlqJPA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2NSBTYWx0ZWRfXxoVtayPxTru0
 TvBw9sSLjFUfh6Jdb3sVQtTxCZIWD8lDZoiK8cmM2dMaaV3r7wNsc5MXZarnpZeZSFPPxq5AXKg
 PBJcTQiPzP1BCYCSg0n4ydVAIl8Tp4M=
X-Authority-Analysis: v=2.4 cv=J4I/fwnS c=1 sm=1 tr=0 ts=6ac67339 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=zhcD6a0htT2TxK9RPLUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: kElbTMO1lDNKje8ykqPM2t81LGzXezYe
X-Proofpoint-GUID: kElbTMO1lDNKje8ykqPM2t81LGzXezYe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2NSBTYWx0ZWRfX3igGxsXMUAfV
 P7meuVgapcOtsKqS0XxNpqtf2pjS6ytRR9q/Cc4uhYlCv+JzWd31RdJNeoP97By7CrbHn2NmejP
 1olL2Mc6RNs19xwZ25Pzv5YACQtVC1Qd3iV9CkaINvxOi0CHgRJ3t3QvEDUpe3qJ96gud1ne1/H
 QB+ltSGlkNemx1iR+ClvLvQSfTwsziSLMFxa6yLbdq23NmGzJkZE4JtDqjRuM+zQiuSVi3cYM0c
 Yl8BhTi5H+4WRF4eNgzY6UDB9/9sALNwmdITvdnsVNgH/SnoPCIdZhmA5J4ksYL7rps0+EFFFfD
 MtC++VvgtTjLQraVjau3DYvw6D+Gfn5ZCadHRnPVi7KH/pkcf47b+sTYrdeQLx0c4POQFzCGOqg
 BnWSL/aj/uwHjEfcuTE38hXJv2/BfBWS9fD58SWlEbBlj3Rgjk0CwZxQVtT2BZGWIaZrSN51qoc
 AbIchKS7b3r0r/IWzKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070065

With Clang 20 and CONFIG_FORTIFY_SOURCE, stacking Landlock domains can
trigger a fortify panic in the handled_masks copy in inherit_ruleset():

  __fortify_panic
  landlock_merge_ruleset
  __arm64_sys_landlock_restrict_self

Clang miscalculates the location of the __counted_by counter in the
anonymous structure nested inside the domain's union.  In an arm64 build,
__builtin_dynamic_object_size(domain->handled_masks, 1) reads offset 40
(the first handled_masks entry) instead of offset 36 (num_layers).
Because the destination domain is zero-initialized and its masks have not
yet been populated, FORTIFY sees a zero-sized destination and rejects the
copy of the parent's layers.

Move num_layers and handled_masks to the top level of landlock_domain so
that Clang uses the correct counter.

Assisted-by: LLM
Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Move the domain layer counter and flexible array out of the anonymous
union to work around Clang 20 reading the wrong counter for __counted_by.
This fixes the FORTIFY panic when copying the parent domain's layer stack.

Based on next-20260930. Validated arm64 Landlock object builds with
Clang 20 and GCC 14, with CONFIG_FORTIFY_SOURCE enabled, and checked the
counter load in Clang-generated code. Not boot-tested.
---
 security/landlock/domain.h | 48 +++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index caa3d19d2c43..5e65ab004f62 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -216,37 +216,29 @@ struct landlock_domain {
 		/**
 		 * @work_free: Enables to free a domain within a lockless
 		 * section.  This is only used by landlock_put_domain_deferred()
-		 * when @usage reaches zero.  The fields @usage, @num_layers and
-		 * @handled_masks are then unused.
+		 * when @usage reaches zero.  The field @usage is then unused.
 		 */
 		struct work_struct work_free;
-		struct {
-			/**
-			 * @usage: Number of credentials referencing this
-			 * domain.
-			 */
-			refcount_t usage;
-			/**
-			 * @num_layers: Number of layers that are used in this
-			 * domain.  This enables to check that all the layers
-			 * allow an access request.
-			 */
-			u32 num_layers;
-			/**
-			 * @handled_masks: Contains the subset of filesystem and
-			 * network actions that are restricted by a domain.  A
-			 * domain saves all layers of merged rulesets in a stack
-			 * (FAM), starting from the first layer to the last one.
-			 * These layers are used when merging rulesets, for user
-			 * space backward compatibility (i.e. future-proof), and
-			 * to properly handle merged rulesets without
-			 * overlapping access rights.  These layers are set once
-			 * and never changed for the lifetime of the domain.
-			 */
-			struct access_masks
-				handled_masks[] __counted_by(num_layers);
-		};
+		/**
+		 * @usage: Number of credentials referencing this domain.
+		 */
+		refcount_t usage;
 	};
+	/**
+	 * @num_layers: Number of layers that are used in this domain.  This
+	 * enables to check that all the layers allow an access request.
+	 */
+	u32 num_layers;
+	/**
+	 * @handled_masks: Contains the subset of filesystem and network actions
+	 * that are restricted by a domain.  A domain saves all layers of merged
+	 * rulesets in a stack (FAM), starting from the first layer to the last
+	 * one.  These layers are used when merging rulesets, for user space
+	 * backward compatibility (i.e. future-proof), and to properly handle
+	 * merged rulesets without overlapping access rights.  These layers are
+	 * set once and never changed for the lifetime of the domain.
+	 */
+	struct access_masks handled_masks[] __counted_by(num_layers);
 };
 
 static inline access_mask_t

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20261007-b4-landlock-fix-domain-fortify-panic-510367f8cfe3

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

