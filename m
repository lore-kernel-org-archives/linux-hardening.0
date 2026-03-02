Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089635CBD7;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469669; cv=none; b=YJfV3w/bgGAG4JLOHlnYjQqbFSn5+7mfETNJyaeKhTJKvIhZSiSDuyOrXpwjy1HWBfZ6qRAsdhbhNm4cTriX4nCjwbsPhF8IZW53BR86hTSycqUmLRMKQ/am5gwN2kwOH2AqIZo58i2sV6DRBprVTWQTFuacFSbgV0PdTVHC4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469669; c=relaxed/simple;
	bh=Mq94eCCs+RKATmleknUccsvrIqNogkHHQ1NGR1scPL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjnmaZNyx9YzKDM+5pITQps71U7CuE1hiKumkvXRa9fqpKdwdbl+0hKhcI/6PWaAGDjW4ycOT7oydxSUMbCMiAReqGyf0oZVTIBWQiUEsxL+LWynD0hsiw9oTKBkV357I8RBazD/2G/5blJTifzlI5Q1tgvaP2YJm6Fka3akhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMgepz2i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMgepz2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70318C19423;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469669;
	bh=Mq94eCCs+RKATmleknUccsvrIqNogkHHQ1NGR1scPL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMgepz2ijwJ2lQZdNDNyl/x7TVksfnAOjg5d/9XXaeFFNnJY4mPW+RTQDK9BFAp8J
	 RSzo7c1VNJGZsymdwr3Hotm7sbyvt7/++jmjR4bJNjXD9Uzfi4/EGOyVjfqbXRJly4
	 oVc7v0l2WTZOrg0YRc+ehvx2wu6rgiJdJ1nG6+WMPtU1kgVHRq4nzehLfF6fiZo5qs
	 4yTuxkcMKvsDcMP28k8oa6kopTamVnNjJwwP0/b4yJQ1/k5Afe6w4WE4K+UO1s4Uzp
	 ozSIStTLFXRk4PTKnqse1CZamCsCc0wvVVpAyWeiCmP7SF2Q1OBICmxWcuhzxsxQE5
	 PqDLAZon2rz3A==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KQ-000000002x1-3bCs;
	Mon, 02 Mar 2026 17:41:06 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 01/18] docs: kdoc_re: add support for groups()
Date: Mon,  2 Mar 2026 17:40:44 +0100
Message-ID: <20d1a9c77200e28cc2ff1d6122635c43f8ba6a71.1772469446.git.mchehab+huawei@kernel.org>
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

Add an equivalent to re groups() method.
This is useful on debug messages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 0bf9e01cdc57..774dd747ecb0 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -106,6 +106,13 @@ class KernRe:
 
         return self.last_match.group(num)
 
+    def groups(self):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.groups()
+
 
 class NestedMatch:
     """
-- 
2.52.0

