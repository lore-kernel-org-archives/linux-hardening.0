Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF03AD52E;
	Thu, 12 Mar 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299554; cv=none; b=p8hZnDeBUOd26FjigUrLH7xEudlRqmtHlK0CWtmcS7C3z4t21vqQR8Sqo1rCWZD2C+cuWbViTKASy8aU32g7t/lO+UyRoK467V7K+IFiwrTfZQOR1CFcrV/5ueisdZ2Rr/Q/jFqGT4mdIIMvQxucYKAWXK0dQ1eAMoQOpSC42cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299554; c=relaxed/simple;
	bh=0chB5Q8mELtk7nIsVOn7tboqMd7he9vt6/MdSJhiwBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpBiE6HN8ZgLEMErmEAF0eiP1Ipk5Lcu6pdyHoLLTm0jIz5IC7nHIZbWmBoMxeZ9UCsio/+N8mD6NOVS24ZAfMZaRzvUv/b5hSAjzoRH6avzc4GAPOLHfWU9r7b9euFG22esanSjegP32+qW6u3qOL8j157ZxqyRt+PZLlk4SAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBDauuTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBDauuTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864C9C2BCFB;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=0chB5Q8mELtk7nIsVOn7tboqMd7he9vt6/MdSJhiwBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QBDauuTQpfbr9GhrzAdhauPG6l+HPthWj/CXUp9OrfOuFGVedv4HECwHBgBWmCMsu
	 XHklR+CcGIu9o7II1aOfTmNcYTrrZpwtF7I283Zb3C+m51GTCKGKQdQeTdbF8E6kRp
	 x0h5a5rITAcFAf4wBNn3dz6JuvXWahc2irK75aTmSSXR+4M6J9LUoXnXtcs60AoOfC
	 LjGQLo1Fc6qPv9BOdr6X08Et0U54zmqFzNQTBDRoJtmlyX3uh2nXk0sh4O3K8x2dV4
	 1qd7jjulFJmID8wEXGntt/E/P88sVVuRmWx18eEc+dxO2TytRjElKHFSqcQGPOAe2Z
	 y4/wMwcqvHxtw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077hZ-3Ngw;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 19/20] docs: c_lex: add support to work with pure name ids
Date: Thu, 12 Mar 2026 08:12:27 +0100
Message-ID: <8ad16ddc6d68d0cc09a16818b240df467a2c7d93.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773297828.git.mchehab+huawei@kernel.org>
References: <cover.1773297828.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Most of CMatch complexity is due to the need of parse macros
with arguments. Still, it is easy enough to support also simple
name identifiers.

Add support for it, as it simplifies xforms logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 98031cb7907c..689ad64ecbe4 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -477,9 +477,17 @@ class CMatch:
 
                 continue
 
-            if not started and tok.kind == CToken.BEGIN:
-                started = True
-                continue
+            if not started:
+                if tok.kind == CToken.SPACE:
+                    continue
+
+                if tok.kind == CToken.BEGIN:
+                    started = True
+                    continue
+                else:
+                    # Name only token without BEGIN/END
+                    yield start, i
+                    start = None
 
             if tok.kind == CToken.END and tok.level == stack[-1][1]:
                 start, level = stack.pop()
-- 
2.53.0

