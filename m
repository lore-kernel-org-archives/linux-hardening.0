Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583AC1D5141
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972138; cv=none; b=AW2/gIOXdS8IOIp8MXVSyIiyqt61FB+Kh83RJNeL6BlPAmTuyiKdPdR2UEHBJTnN+mUO4VuVqT858C8eir6QO4CNyhizQUnhbu98EDOs8PmFaFbdq6eW6hy/qF8yKIic2q1RN1NfzOcH+q7hiz8ioAAPMG8OLNtMT+tuLqLYeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972138; c=relaxed/simple;
	bh=/0dRPRjqg3IHIqgYOrn2vyyviwdlxxFzHDkKNcZEB7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxX8mP0L57zluyyA4KPkLQoFIcaeYK2CMV3wUI5xWCU0gcudkSWteCgeoPSzVKeTrigmtJEdQpPIkx6YdZ8VpsS1hORV36ljMaH4oHDFPiU9Tt+4M8Vb/NREDS0T7dT1m1tMPi/KNO/3RuP15+lpdgqpZdHqqm7h57It4OxsOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOcCxIYH; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOcCxIYH"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a2ea96930cso31252815ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767972137; x=1768576937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l02srCpqwS/PPVAYoAwmWqO0txf7t8pnFoogY5rh/QA=;
        b=KOcCxIYH7ZfzPZW1EgMeCaHB8qzTB4V8M6dVzLqboXwd/Hov8grmVhhBnWFEZruIAI
         PMH0+w7EJVtTiszm0ibb3c6A+OO7Fbgdc6nvKgbjcB/ADx8G31SitVtH4IoVhgsx4gvb
         sXkIFHmq2xukww/+00iDj7O+MzukW+exdkkWyyC64XiVGnGYNfn3cvvHzInhciOS9u7m
         lSCrsIQ4YHxdDejbHnoGFTEbDhuoPsCCCRQ1KbvSzb+cS9Yc91uEZeq2K22cxB9sA84Y
         4MUtGye4XgcRrX8rQ/8/62/jgNMMSPOVG4ORPFgv9S9137O29rxrOFAkUd3PXIWZlr4r
         9Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767972137; x=1768576937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l02srCpqwS/PPVAYoAwmWqO0txf7t8pnFoogY5rh/QA=;
        b=MrbjvcfUpBC93YSWyaQ5wczE5tqGgWK1983rD88zEvbmhUqWBi2dnogIGAMnbyOc9h
         GCMvkuhQk1Nmm6In7iePw/wc7appfhinUD4DLlro8PlPLRqWFZktS1cymwusZHdmuNop
         Tlt6bhrW7GCTvbaXKjJhegtmaFKyrLCF2aqckj0qEHryWzeHudOHtu3F07drcz8/dTQ8
         LVJz2E3mUg45k55qTzhWVKGorS4IH0qZUJ2PJRRLG/QQwa/V5JikG6UtFWUdhWrRyc0r
         pFqMimB0sEbYmt4f+VyvvGtpfCSuVWdb9vv2gBgVMolzyjSdbcFh9veQq7RoLxfVGBrK
         nC6A==
X-Forwarded-Encrypted: i=1; AJvYcCVghMuwxYJmfvZs9moUsXpOrjOMLefsrX2FrX8/O0U+MSLSx5/PFt5YXRiX0mhyhXVrOIyPd5JrS3Wy05vcXfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2MTKMDBPAT9BTvPbKERBbQS78+P6gRvNBwqphiT3AmfGPGpMt
	lIkrt5Rgp7SoCzEp2IGIdvTTQ0E5fRLJfkeeESm8mdsHvgz3dk8dp8AD
X-Gm-Gg: AY/fxX7ssnj3C/tfH+cC1RL+czkOPGCV6NB9u8bbCKSD7az3gi5AV+wYBrJyWC1GtU/
	N1IxBwXeyvUlJy4lTQHriVNOgjXgcgsHT8IARcrBZbVAm3vibNHWVXrPnlHVdjfSMod6WTGvEUQ
	LOSDFZ6GUN96HEL8KnjGUW26d3GmQg03t++wHUv41oxXNsR6rEkkLrfEB8HOCGriQXCx8oCm5nI
	hPzHw6vbMdjhO14203crUZ9NAn0TEwCxk1x3SV9hveEtklGIwnruEoeP/AbxHs9C1SFFOzRjncS
	Gluycwhb5FbMg4s+Jr1snFdLTpS1kjEiFOQ6D3Cmah0tzNB/3p6gttyU6dMfRu7UkWQapNo3PVP
	uWK8wr9K0wYg2Yc53D+XLueUWiXQfE6AZHzVm/J17Ew3Rw0IW1guP0Uf9aqANllXEaMk82PBeVS
	g1R63LHud8mTPl9jpafxKg02Mw4dfDt3RykBfCENe6
X-Google-Smtp-Source: AGHT+IFjwhs5i9G743dkgLzBhWBTZ55yy5yc6JsaoH2/JUYyPH+SQo8zbecqIuA/7HClY6kISME1yw==
X-Received: by 2002:a17:903:478d:b0:2a0:b438:fc15 with SMTP id d9443c01a7336-2a3ee468407mr97193875ad.11.1767972136629;
        Fri, 09 Jan 2026 07:22:16 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc87f8sm108021895ad.77.2026.01.09.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:22:16 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH RESEND net-next] selftests/net/ipsec: Fix variable size type not at the end of struct
Date: Fri,  9 Jan 2026 20:52:01 +0530
Message-ID: <20260109152201.15668-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "struct alg" object contains a union of 3 xfrm structures:

	union {
		struct xfrm_algo;
		struct xfrm_algo_aead;
		struct xfrm_algo_auth;
	}

All of them end with a flexible array member used to store key material,
but the flexible array appears at *different offsets* in each struct.
bcz of this, union itself is of variable-sized & Placing it above
char buf[...] triggers:

ipsec.c:835:5: warning: field 'u' with variable sized type 'union
(unnamed union at ipsec.c:831:3)' not at the end of a struct or class
is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
  835 |                 } u;
      |                   ^

one fix is to use "TRAILING_OVERLAP()" which works with one flexible
array member only.

But In "struct alg" flexible array member exists in all union members,
but not at the same offset, so TRAILING_OVERLAP cannot be applied.

so the fix is to explicitly overlay the key buffer at the correct offset
for the largest union member (xfrm_algo_auth). This ensures that the
flexible-array region and the fixed buffer line up.

No functional change.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
CCed Gustavo and linux-hardening as suggested by Simon.

Previous patch: https://lore.kernel.org/all/aSiXmp4mh7M3RaRv@horms.kernel.org/t/#u
---
 tools/testing/selftests/net/ipsec.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 0ccf484b1d9d..f4afef51b930 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -43,6 +43,10 @@

 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))

+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
+#endif
+
 #define IPV4_STR_SZ	16	/* xxx.xxx.xxx.xxx is longest + \0 */
 #define MAX_PAYLOAD	2048
 #define XFRM_ALGO_KEY_BUF_SIZE	512
@@ -827,13 +831,16 @@ static int xfrm_fill_key(char *name, char *buf,
 static int xfrm_state_pack_algo(struct nlmsghdr *nh, size_t req_sz,
 		struct xfrm_desc *desc)
 {
-	struct {
+	union {
 		union {
 			struct xfrm_algo	alg;
 			struct xfrm_algo_aead	aead;
 			struct xfrm_algo_auth	auth;
 		} u;
-		char buf[XFRM_ALGO_KEY_BUF_SIZE];
+		struct {
+			unsigned char __offset_to_FAM[offsetof(struct xfrm_algo_auth, alg_key)];
+			char buf[XFRM_ALGO_KEY_BUF_SIZE];
+		};
 	} alg = {};
 	size_t alen, elen, clen, aelen;
 	unsigned short type;
--
2.52.0

