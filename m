Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317B352C43;
	Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409612; cv=none; b=ioJK0zodUZw1HoJQI9y4ntZjZJlmNzqFKEnr5sMZUHPMsg6tGoqRm1reETEnvKexd6s47B+1E/PPwx7oXNluc3CTk1DO5/G2sQeVrpreYL9PXyL0mq0Nijr2J/2zaQSl8yTqJxWp++NG1R+0XmBKQ874qjWujcQ9/U4coKzBjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409612; c=relaxed/simple;
	bh=J9gpBcUhWSmksHEje7HfFrvd/UJKiZjrUhxoxqAfK3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8XwflTzUJ3I2TaLjTKMmkhJMCp/6ekFEPei14E4FofVepMWrM9Tv+bYaCV6Rfe+j/czxam0RpzR4+fLx7bSh6gyg6/bpY4SLheYLjaEZ+0/m3APcy1Jlj9Q01q3sV20jTtYgJFxXZczOATCjVxymwOcfo20cKUq9pXTfZlmbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGaRpMRO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGaRpMRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8102C2BC86;
	Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409611;
	bh=J9gpBcUhWSmksHEje7HfFrvd/UJKiZjrUhxoxqAfK3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGaRpMROqM8qzVFGoU6huHazI36POCwMiUwUU3rvaf7mizJI7r7BYYXt5NPl0ZIX2
	 rl4YDhZo7lFrS/0MQl5Vb+OI8DimUdQo+H9NbpOOb5g8Uqyf7w8U53PBJzcGIw9oWf
	 PpncsMHuc134d0WmDE2dFuaWdQr102z+sKsRKrzIo+PlL1sPrzXi2Czv9SLMpIfjAh
	 RcYgv06eKI3xJk4qgGaMZIAJ3gjTMn8CY5Zdp53QzvGfzh7d2aCPEqJquICd5nuxzv
	 4GI5MM+TUvoRebTWS8p/m3B7dIEJPRWJOf38Mv+811CCAMloTtZ2C/jc6LHmFMeBfX
	 aWLw+TyMJ2kgg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYk-00000000M03-0i2s;
	Wed, 18 Feb 2026 11:13:30 +0100
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
Subject: [PATCH 34/38] docs: sphinx-build-wrapper: better handle troff .TH markups
Date: Wed, 18 Feb 2026 11:13:04 +0100
Message-ID: <dd1fa03ab5432016a3b05fb1e40dca57485d3a4d.1771408406.git.mchehab+huawei@kernel.org>
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

Using a regular expression to match .TH is problematic, as it
doesn't handle well quotation marks.

Use shlex instead.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index b7c149dff06b..e6418e22e2ff 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -576,7 +576,6 @@ class SphinxBuilder:
         """
 
         re_kernel_doc = re.compile(r"^\.\.\s+kernel-doc::\s*(\S+)")
-        re_man = re.compile(r'^\.TH "[^"]*" (\d+) "([^"]*)"')
 
         if docs_dir == src_dir:
             #
@@ -616,8 +615,7 @@ class SphinxBuilder:
         fp = None
         try:
             for line in result.stdout.split("\n"):
-                match = re_man.match(line)
-                if not match:
+                if not line.startswith(".TH"):
                     if fp:
                         fp.write(line + '\n')
                     continue
@@ -625,7 +623,9 @@ class SphinxBuilder:
                 if fp:
                     fp.close()
 
-                fname = f"{output_dir}/{match.group(2)}.{match.group(1)}"
+                # Use shlex here, as it handles well parameters with commas
+                args = shlex.split(line)
+                fname = f"{output_dir}/{args[3]}.{args[2]}"
 
                 if self.verbose:
                     print(f"Creating {fname}")
-- 
2.52.0

