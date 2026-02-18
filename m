Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9633F8DC;
	Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409612; cv=none; b=m+EFWoqhlbxs94Cw4aFw5jD90sqTu5AkI04YDckUPvsiINM+OC6ep2sxRQNxJxFtjHH2lvoYscNI7FjIcD88vCV5A7o6847XtzLbe5EuafClg4Pq3G1D51tiV+HV+udLJjUJBc1niI6Jvz6fEGOP6lefNj5YAcpHvnjZL+d4LIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409612; c=relaxed/simple;
	bh=CwHsRCLR3wmM4G7G9vnHWInI3q03RKTr8dBQN45i3sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkuOiGU/nrYpVIBDXkiUgMuoSxugvdBhwLqCIIBPnGl1nOsx5680ciVJaTghcry5ITvS0nzncz5aVRt0qB+GIyRq6h0/xSMDlBnJQZbt2sqD/VFxDkuMFj3GNJMyhX/d8zxSE2+52/8vGxGonxprP4A9kmOcZ5zBno4OQ9WJrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX9EP0jK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX9EP0jK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88843C19423;
	Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409611;
	bh=CwHsRCLR3wmM4G7G9vnHWInI3q03RKTr8dBQN45i3sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iX9EP0jKJG8PffTHhAtfpwxm8+/JqYKhI9wEOAf9UsS609BzL4rTzoDyCS4yiTDHO
	 fx6srtY75shT23w603e7nsB3DdtE9yxY9DmWMvsSYziUMzUe/lMUGIk6GSGbaA9qpw
	 5d78qxduPlfo4zZAKpcApx/5tk5bpxKp7byUKNLdkbgc1y2J5fEQbakS5OwypzeXFL
	 zJylyilRu7/WBFcbI2os81lo8UyFUP8pe7lGFlwAs6DdczvN6b9Znbrj9drapcH+WP
	 fvOOZAejGlAJ1FBQXc1tfBHK502VqdPOizOY1+9UWxvWy0Nvk2jYm5MKs53WJ2KRMa
	 8NEc6iPJZIs6Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYj-00000000Lyr-3Nye;
	Wed, 18 Feb 2026 11:13:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 33/38] docs: kdoc_output: add optional args to ManOutput class
Date: Wed, 18 Feb 2026 11:13:03 +0100
Message-ID: <45e9f1cccffba1d8c39b9e439efe694e1426a717.1771408406.git.mchehab+huawei@kernel.org>
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

The current logic hardcodes several values that are placed
inside troff's title header (.TH). Place them as parameters
to make the class more flexible.

While here, remove the extra unused "LINUX" parameter at the
end of the .TH header.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_output.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index 4210b91dde5f..fe3fc0dfd02b 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -607,7 +607,14 @@ class ManFormat(OutputFormat):
         "%m %d %Y",
     ]
 
-    def __init__(self, modulename):
+    def emit_th(self, name):
+        """Emit a title header line."""
+        name = name.strip()
+
+        self.data += f'.TH "{self.modulename}" {self.section} "{name}" '
+        self.data += f' "{self.date}" "{self.manual}"\n'
+
+    def __init__(self, modulename, section="9", manual="Kernel API Manual"):
         """
         Creates class variables.
 
@@ -616,7 +623,11 @@ class ManFormat(OutputFormat):
         """
 
         super().__init__()
+
         self.modulename = modulename
+        self.section = section
+        self.manual = manual
+
         self.symbols = []
 
         dt = None
@@ -632,7 +643,7 @@ class ManFormat(OutputFormat):
         if not dt:
             dt = datetime.now()
 
-        self.man_date = dt.strftime("%B %Y")
+        self.date = dt.strftime("%B %Y")
 
     def arg_name(self, args, name):
         """
@@ -724,7 +735,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
@@ -734,7 +745,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{name}" 9 "{out_name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -780,7 +791,7 @@ class ManFormat(OutputFormat):
     def out_enum(self, fname, name, args):
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"enum {name} \\- {args['purpose']}\n"
@@ -813,7 +824,7 @@ class ManFormat(OutputFormat):
         out_name = self.arg_name(args, name)
         full_proto = args.other_stuff["full_proto"]
 
-        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -834,7 +845,7 @@ class ManFormat(OutputFormat):
         purpose = args.get('purpose')
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"typedef {name} \\- {purpose}\n"
@@ -849,7 +860,7 @@ class ManFormat(OutputFormat):
         definition = args.get('definition')
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"{args.type} {name} \\- {purpose}\n"
-- 
2.52.0

