Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7A426D1E;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469671; cv=none; b=WieWPNz64ZRHPwIAyK604FkjHaCFWhluxlRvJHbmYFoqvw4FuuaxLCrhIKOpDwnSa9KnNKnWyRNRkPy/2ygTiLibCMMpTD92IPZjY+OOvsF9k2pgrty6XgF2qANr3bu9wm7OEDj5oFOfyGFEaAT9475/5/lGCebmbdhsJdZRbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469671; c=relaxed/simple;
	bh=TauImqU7dyAB+n4W/42lNCpNZkqn+rlErO2lHzaJpt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV2x+6YDwUuWQK50RfHfK52Ydh6V6J29oWEiFm+AOjSvHAVTTpLYnp34ZUyPzhyfP9A5yGFP20v2zscBqzANhdKH3Gpg++vxMayHqQfeoDX9VJTMKp6pPhMW4bxMqi3eO2lg8DX208mjxt+uDFJYHt4DlS65/BVlAzanBl3tMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqPKaFZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqPKaFZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF8C2BCB2;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469671;
	bh=TauImqU7dyAB+n4W/42lNCpNZkqn+rlErO2lHzaJpt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqPKaFZkvBv5yyfQA8IEd34tg3mXHSq41TaivZWBpA71dsv4etobTZR1ishTroAb3
	 +OV+ipl1j3cgKQ/WbvI5GgWTkiYY5wT6MNy3JZwALai3/JlnxEH/ch0r9yFqIo4Izk
	 cuSPlIC1h3iZTHHyPKBvJTbAKjtauAi9ML/2NrKGDIWgI2nH1QJtf/k3i1WdcNdjBZ
	 XJCNP1d118CUtL4EEasM4U9HJzOwDeRBo1y97Qr9Vg/dhI+wCm5p7gLJ2JP9FsfrmV
	 uQvMLV6MNIgIIveyhobviF+Q+uvEzsaMJqrMtPHiJ1OS6O786l1YD7ngC4/4MhzOGX
	 mfHFPtBHqkmWQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KT-000000003DD-1dMp;
	Mon, 02 Mar 2026 17:41:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 14/18] docs: kdoc_re: handle strings and escape chars on NextMatch
Date: Mon,  2 Mar 2026 17:40:57 +0100
Message-ID: <ac25335bc2d09649e17d1c86c17d3f8f2e8ec27c.1772469446.git.mchehab+huawei@kernel.org>
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

The logic inside NestedMatch currently doesn't consider that
function arguments may have chars and strings, which may
eventually contain delimiters.

Add logic to handle strings and escape characters on them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 664c04c8cc9f..0a7f12616f9f 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -216,6 +216,8 @@ class NestedMatch:
         for match_re in regex.finditer(line):
             start = match_re.start()
             offset = match_re.end()
+            string_char = None
+            escape = False
 
             d = line[offset - 1]
             if d not in self.DELIMITER_PAIRS:
@@ -229,6 +231,22 @@ class NestedMatch:
 
                 d = line[pos]
 
+                if escape:
+                    escape = False
+                    continue
+
+                if string_char:
+                    if d == '\\':
+                        escape = True
+                    elif d == string_char:
+                        string_char = None
+
+                    continue
+
+                if d in ('"', "'"):
+                    string_char = d
+                    continue
+
                 if d in self.DELIMITER_PAIRS:
                     end = self.DELIMITER_PAIRS[d]
 
-- 
2.52.0

