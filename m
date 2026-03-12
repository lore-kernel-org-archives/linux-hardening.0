Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE937C901;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327302; cv=none; b=aqfzgYOuutKAUfORU74H+NRfmr/nzB6ZnbB8EMZEAqH6XXZJom1e36XXx45lisreRIpsaPFJiiFjqQi5/gzdZZMSAaNzOBnrSPZESpltigk8j5cX6W+7/JeHRdDWAk1O6LspRRTpQCG1yC57wSimbeunx6tQs89gmc5+PYp+nm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327302; c=relaxed/simple;
	bh=TmYHPBWmiJoumgXDNjybq4wZqraDZtMhzikKfDnelmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmpMdbCup4uNpa+alYTXVP006/BTI/8X1IDTHeOyg89s1rs23A7lGp1AR+fsNpPwS9t/C0tgp3uhcfft6JmIzW8kiZoD7P3jk7EUezfF6rGkPwOh7PuQcbAFe52octw9OyxsUnFvhopofaQ+RQBPUDNuR8Fo8eTYJE8FkCihZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X74Jg69c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X74Jg69c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F02C4CEF7;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327302;
	bh=TmYHPBWmiJoumgXDNjybq4wZqraDZtMhzikKfDnelmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X74Jg69cPp+8b5T6fFQfVzPaBkEJ4Rz4JFWG7PCTZy3n8zAMVjABXFgjqoKwW/s5u
	 GpsQJYrx8upyaga/N/kUlEaA6mw/AT58pjeGOKjUTYmskMKQY78EJFf+3hT4s6uCju
	 DorAgEYS1+QtDLXHTFxV7h3ZfV608iUOxiVvrKmmX3TZCccTZeFPcJgMzvbh7R1rUu
	 gaDc1XoGy1tMkfNeXyIsBtWoL0U5QHCKqpOXwQZ1ENDOTLi2YoJRc38ieXDOz4x9zE
	 /erdgMAU9UzAM59sscM8DrRdhc/SuBZg1TOYRh2kN8/4uVyVV1dA7GWbbvpe9I8YrZ
	 ORNtOf+OIXhTw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRE-00000008yHn-1vRn;
	Thu, 12 Mar 2026 15:55:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 26/28] docs: kernel-doc.rst: document private: scope propagation
Date: Thu, 12 Mar 2026 15:54:46 +0100
Message-ID: <6bdaba027c1d605df9f71ee504d8e042a71b18c9.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
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

