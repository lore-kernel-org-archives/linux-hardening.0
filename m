Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591765;
	b=igOc0K47aZ+5G0jQ4rb0bMEglA6h5AnX2DbgzsTXoqQ81C6lU/wJ0Pmw/Vu718cTYK+S
	 QUhaher77/R9Xn+aGZtdYi+1aQ8Sv0VspmuPGEv3y0vuyKmG+B8nsJrxiGvWQUqZQPPLx
	 ngo/SvBZb14q3ruB4oe3AJlTep48T6EB/Thq+EVbzEBJV7C8ZcCHjTx99EmA/Hl/BJEs9
	 GaZKR19BBtPNAciqG5OMM2KKYoG45aSGSUVU2OEPoyN2ByTGjvN0lHsArM5+/RRzozX0M
	 3bsqNfeQ9y8TChJtkmSUTBXsxBzmeSv9n10VC+WDrX+lwmDV/RamBcXoRphLggItNpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=ZB/j2Y+ajec24/8et75ghp7KfZsaiFEAzsihkwlDilQ=;
	b=SktYbh2EioJs1VUobbLXdgD+2njPgGOf/JUfSCxt+WxeUhGUxZ9F7ckSkbYkPMQbaGlq
	 X6pL+BQabDKlNDm5Wafd50miTrDFyVrAG0UTsIK+tZyk7oYt7MrvfbxS7v0/RUZrNAzyO
	 jwG8F8ogK2LoaEJHwcTDLQsOv7OLNScj5Nj9kv77os5DZt3TYWUtsbx9Wlqb64mIyXOjp
	 0xid74yspHbBkHo/TpAZsj4s3l4ISNfFlCpbcojXfjVMVBbeA5w6q0J0aznsVH2wJ2MPP
	 0EVDvT8XXGjxX4OJMb6oRBqy8hl7hNaw0V0WuL47+/BAs5mMh5OpKZMaT/JekG3Wi8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bqdxbtab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A61606A33A;
	Fri, 13 Nov 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bqdxbtab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB911F000C4;
	Fri, 13 Nov 2026 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591765;
	bh=ZB/j2Y+ajec24/8et75ghp7KfZsaiFEAzsihkwlDilQ=;
	h=From:To:Cc:Subject:Date;
	b=BqdxbtabkdyvXWTyMXAqaiUCb/ZWlynacmGazxvyRqw7qMRDxtKkDDlbAwGSdQ5xg
	 dMtrQUlT5mbSpkgKfQLu6qAOZ8xaSKNdDjIpN0j91beE0OCbaiwGAz/6iMAvQpth3n
	 dZsRFGuoXIBvdHEWkqcmB0XsDpbBPrxkQPG7yx4k05SOCamg4Vtou9Rcm0qaa7qoX+
	 Zqy1kn/2/RDvVmrglnFieJeTxSqoTym+OQslt/7JTv+Vh9vTmM1QJE+QNunIsv5Zab
	 CBhn0NsJYmgsAVUUVtIstTSUMWNNde/wbQaIzxVpqZkNjeigmt2PCQId3TBQn4oyXy
	 nu/8ubWV83VyA==
From: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] dt-bindings: reserved-memory: ramoops: Update Kees's email
Date: Fri, 13 Nov 2026 09:42:41 -0800
Message-ID: <20261113174237.i.303-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=kees@kernel.org; h=from:subject:message-id; bh=GC/mDh6VeYmI6daJlmvsekB/zSiq87wEfX+IW8DztTs=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnffQTLGJnuKe55+fp3xXv9i/oPjbob7+V/Z3ivXLz7W 4IGj0pdRwkLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESkFBj+6X4rKv5h4FW8unfa xKlnF3EdTY7T1jc/4bjui9WG9kdftzL82Jjn8pdtit/SaYY/J+pbawkpBy6zuDnzNXN8uXDUTU9 eAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Don't rely on .mailmap to get things emailed to me. Update to my
@kernel.org address.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 Documentation/devicetree/bindings/reserved-memory/ramoops.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
index 45cc39ecc9f8..5a12064eb3c7 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -24,7 +24,7 @@ description: |
   must be set non-zero, but are otherwise optional as listed below.
 
 maintainers:
-  - Kees Cook <keescook@chromium.org>
+  - Kees Cook <kees@kernel.org>
 
 allOf:
   - $ref: reserved-memory.yaml
-- 
2.55.0

