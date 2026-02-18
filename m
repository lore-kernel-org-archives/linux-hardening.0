Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B403587B3;
	Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409615; cv=none; b=aLxA6teDJDnmdwdbbvBiyP4887KOKpVCxLYbh96/J06QSM7hmoZBt2EERmv6EVbAzgrrYCkhxU9Z3jpo3XkI+JY1nhQdGL5C3mssereBPnuTmm+s92UGVKXTZZv5t7X3STdyfeVwePCJ99LVJRKz3uLnFT8A7yNhwmqZ8bxfz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409615; c=relaxed/simple;
	bh=StLiyG6YMI5Qu+bnXMhDG5SBpIn/ZhlyGc1i11g1b5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVhD0IKyHm7TlwfjPblIBMT41jaPP/dBBVYN55phYmgdkkyRnarbg62mC2nCwtxSrzO5gG8grhj3ilb3lg0ifxb/rMds2r9CX8Jge070196mXvWPGV8Zlq/rcaNN+iYwJIOB9v5NVhr9IlpvOn0pwDCfkv1y73QuyEWFpgLa178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH4vkffY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH4vkffY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF45FC4AF09;
	Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409612;
	bh=StLiyG6YMI5Qu+bnXMhDG5SBpIn/ZhlyGc1i11g1b5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PH4vkffYkqJW5ZJe/JehvYwIYLyV37DkmsbCHziw3ZVSjHd4EliM7zDIQlCjtaU0Z
	 U20j9CXVrMqrxjt74/nCU9pV909y8KZl7Kx29eAoi8pHbTaHCZLWLqkh0edxn8F33h
	 QhfzO7VKCgJy8x9eg+oCwr7h+SKHdBib2ixx09YOEGwNjsXBz0bgbAciMULtmq/712
	 qSIDw4AlysSb8aejoFbM1yB9o2t+2EKb+dpOlHYIaTBUE40qW6WQhk48HGObOlaVOV
	 uQe3rukCNq0ZZnYRv4xNIusCcPOxhwpL7RkYt8ha0BbOjd6/BhAVtz7TQY6WisSC5M
	 3yIFoKlyOeSpg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYl-00000000M2R-00ln;
	Wed, 18 Feb 2026 11:13:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 36/38] docs: sphinx-build-wrapper: don't allow "/" on file names
Date: Wed, 18 Feb 2026 11:13:06 +0100
Message-ID: <343c89692a53b256670c1bd393aff2159dc3faa2.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When handling "DOC:" sections, slash characters may be there.
Prevent using it at the file names, as this is used for directory
separator.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index ac6852e3dd8c..d4bb1175fe32 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -625,7 +625,8 @@ class SphinxBuilder:
 
                 # Use shlex here, as it handles well parameters with commas
                 args = shlex.split(line)
-                fname = f"{output_dir}/{args[1]}.{args[2]}"
+                name = args[1].replace("/", " ")
+                fname = f"{output_dir}/{name}.{args[2]}"
 
                 if self.verbose:
                     print(f"Creating {fname}")
-- 
2.52.0

