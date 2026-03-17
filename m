Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3E3F99E9;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770991; cv=none; b=tYHIHpyMbLMjbO30870FyvsNbJe5MPfwhDTsxG54APG9UgEQKReVK1CiCA09u82HifdV6JkR3uTJNRzOSHDSLhJCXcQFhqos3CLVhntVnD/F3UxypQhb6hOjQPWApEtp7OHHx49KqL76iIbRzn7jyor28NWjOrzc2IaqCiKnW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770991; c=relaxed/simple;
	bh=TmYHPBWmiJoumgXDNjybq4wZqraDZtMhzikKfDnelmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lay7Wfikvd6hEqDm1RjHA3hBdEbVRhyqb9562uYjJGewJMBmJ296qTdD6jnZeC3g4M/SZVBD7Afh7Dvc6Ea9hfJ+bWb1TzEuPUSZuZjN0VKL7cBByllvrUl+6HGzYcvWqsu8CC5U78lWgLiBtlkdBttE1apoWBtHPfam58TfZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj7vYBYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj7vYBYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59C6C2BC9E;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770990;
	bh=TmYHPBWmiJoumgXDNjybq4wZqraDZtMhzikKfDnelmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nj7vYBYCfl+pT13zfzAvDNa1R2d0FYqdakyGUq1T6a1GlOI+F1q6bkl6vrMqlF881
	 v9FlGL2WXumbCIzn0E0cWp7BLX12vVhERF1ZTYQP6QIpaC2NkzsSwC7cWRMM/O1qTJ
	 8j8jr03UBOCzkTzLn9EVYT1uVt7UtdallOtBhnjdv9TuHK46E5PJHzLzqFbHjEOh29
	 N/HVXmr+/KUhJr1NtvurMNuI4KlVawg7QbCu96lVfEMZJAhrZZhFbp0WWhYZ4ODQUv
	 R5kV2Ri5qa5xxBMgcP5HiZu94P5IvhK+k91zDrEh3Tdz/cWBTc7iu+TBe2MrxoTWH/
	 pqUTtH7KhiQ7w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrV-0000000H5bz-0O2z;
	Tue, 17 Mar 2026 19:09:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v3 19/22] docs: kernel-doc.rst: document private: scope propagation
Date: Tue, 17 Mar 2026 19:09:39 +0100
Message-ID: <bbe0ed698c21f3f930a561b885bc8a47824f7f1d.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This was an undefined behavior, but at least one place used private:
inside a nested struct meant to not be propagated outside it.

Kernel-doc now defines how this is propagated. So, document that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/doc-guide/kernel-doc.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 8d2c09fb36e4..1c148fe8e1f9 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -213,6 +213,10 @@ The ``private:`` and ``public:`` tags must begin immediately following a
 ``/*`` comment marker. They may optionally include comments between the
 ``:`` and the ending ``*/`` marker.
 
+When ``private:`` is used on nested structs, it propagates only to inner
+structs/unions.
+
+
 Example::
 
   /**
@@ -256,8 +260,10 @@ It is possible to document nested structs and unions, like::
         union {
           struct {
             int memb1;
+            /* private: hides memb2 from documentation */
             int memb2;
           };
+          /* Everything here is public again, as private scope finished */
           struct {
             void *memb3;
             int memb4;
-- 
2.52.0

