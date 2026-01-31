Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77E3587C3;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=cIrUiTpgrt63aDcfyVob8HkEMzuTGKawiGRzwjka6Rdtl92/JzBDSDAzMDMbu1VPUbXDCERGdYD941inhuaczBxrBmv8xFXZHXdKON3krcK+r+/9UbfeNKeOMwuXDgh1nhP8T8J1+bGTCGgMQPAojuY9gbC5/3wghV8/Hjdsu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=f75PYMG6ddvHOj0au37tuHra8a1RYsJ5qmzwD4SUTjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbfqDGrSyjEwvJtdgeNzhXcTgTHTfU0apN5OB9zuFSLmEFp/HosC2LgNmPJOUSWDHXBjKX01t2hmgvYBLA/fQm6zTukbQCTcOk9Ji6LbSOtlcjUBGd/31S8uliPiQFe7tSz0FlpwPBhfh/wtg3h3E+niesbgcYewrBmz9WhrgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1p0q3/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1p0q3/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AF9C2BCB8;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=f75PYMG6ddvHOj0au37tuHra8a1RYsJ5qmzwD4SUTjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1p0q3/rMjMPWREONbC8rMKcph3t8I45QF2IDKfCfUrKuKcq9HvyuMUORKQSeqoSO
	 l/62TEU6GDqm5+sXuxKGCu0LxVoCSrMoZXv2aqGSvk9sE7IJH9Tmbgk4NbnGj+4Lwh
	 8Ou4aS6bDve+hsKdq6rSEM7nYXRLhxTkimeNGhQ1Pni0UxA4PFIoiWWL9styvraMjs
	 Qah5GB1BvxahKCe7e08+hwOouK12F1U8SnWGsM1NVhN3sxI7zByxNEyBojHHYbsiHv
	 Kb9ZpHitHaOKYubFpvnmr9xVxu+qqOv27H50IN3bSXkof4Ek9bU9TQR9HS9KVQEHgs
	 GhEdoBGmIK8BA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkm-38lv;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 16/41] docs: kdoc_re: better show KernRe() at documentation
Date: Sat, 31 Jan 2026 15:24:50 +0100
Message-ID: <affc3bcc500311dcebc0ded047cff134a7095968.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

the __repr__() function is used by autodoc to document macro
initialization.

Add a better representation for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 1861799f1966..3f405addcc58 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -52,7 +52,28 @@ class KernRe:
         return self.regex.pattern
 
     def __repr__(self):
-        return f're.compile("{self.regex.pattern}")'
+        """
+        Returns a displayable version of the class init.
+        """
+
+        flag_map = {
+            re.IGNORECASE: "re.I",
+            re.MULTILINE: "re.M",
+            re.DOTALL: "re.S",
+            re.VERBOSE: "re.X",
+        }
+
+        flags = []
+        for flag, name in flag_map.items():
+            if self.regex.flags & flag:
+                flags.append(name)
+
+        flags_name = " | ".join(flags)
+
+        if flags_name:
+            return f'KernRe("{self.regex.pattern}", {flags_name})'
+        else:
+            return f'KernRe("{self.regex.pattern}")'
 
     def __add__(self, other):
         """
-- 
2.52.0

