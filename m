Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7261421A18;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469669; cv=none; b=Bh/RfsYozysxDo84XKusUOixdK+jeYeXNMOxsUPFqLH1JYf4atwIjyddBwyKLIrmhTV9q6pK8mgLn79pTkyUaBuL1P47Rr6fgtJmYmJVKaDeCABb/Q0zJFAYO9ZC3z9crJspP8ecHRiwEwwg+Oy1VNYoyCCGGCZ6Qt15n/t6zzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469669; c=relaxed/simple;
	bh=ZQpmZi3xCboNCaTitC+DH8Zwcl8IPzrA6Uao2EOU9sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBq8NbcaCtnNLzVev8XtOKHZevKw/lbY5A4JVYTarpc8RloOGvTYKxg9hYyvCtbqrbV7KprVz4V+Z4utPlY+ioNTbHA8nRWI2J8tXZGqAiPYeSKBaB6i+U7IHeJTbXWskNKvPfkMwtakOSaphpQYibARc8aAPJIF0AUkyP7hW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQHhxax3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQHhxax3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F2EC4AF0B;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469669;
	bh=ZQpmZi3xCboNCaTitC+DH8Zwcl8IPzrA6Uao2EOU9sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQHhxax3PqxDrkJcGF7N3lwkkRJFXuymUfD/qU/71MuSufK/xk0y+g3obvNVWkvj1
	 86RTeWPd+FMUjdYh/hNAkLWuSVqtdGnp/yyXBcKxVte9/CtGDRV4OShEybTvRC2eP5
	 lGPd4EQdS/gIlyZGX0XuSR1PRMPZGOhHKBOHAnmOD1QcMtXNMbJBui2bY7Vf2ytuuF
	 mQJLU6T76Rl16YdfJTreR4zD1M1J4ai/N4uz6OrhlE30CAwxwZVEXx1K3SEm8oHcGr
	 e8I9alQg3J4XjBSc5J/47RnGNEPW3AJa6L0OOQXdFrHecXD0bU2ktfAIMzJUN0UNrQ
	 zUDhMzCK1yuSg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KR-000000002yF-0Hb0;
	Mon, 02 Mar 2026 17:41:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 02/18] docs: kdoc_re: don't go past the end of a line
Date: Mon,  2 Mar 2026 17:40:45 +0100
Message-ID: <bce51ba0260a053a0ec55a7375d6ed7a7c08026c.1772469446.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772469446.git.mchehab+huawei@kernel.org>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The logic which checks if the line ends with ";" is currently
broken: it may try to read past the buffer.

Fix it by checking before trying to access line[pos].

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 774dd747ecb0..6c44fcce0415 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -269,7 +269,7 @@ class NestedMatch:
             out += new_sub
 
             # Drop end ';' if any
-            if line[pos] == ';':
+            if pos < len(line) and line[pos] == ';':
                 pos += 1
 
             cur_pos = pos
-- 
2.52.0

