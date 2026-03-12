Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836663C7DF8;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327301; cv=none; b=U28jnT950x07YOXS8tk21CRq3Cgt0OKAjVmlLcsZRBoXzvpeDLmUcki5vAMEoD47pEMMKtdMhkYQzokQMOJ/sqGK85aJMVmfxw1byCt10AdHSNPJc1tSy8XHs8tk3i8hml23xDhTvePEFVtWCiIyGQ1fgbfi4bxK6/LvhzZ0hA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327301; c=relaxed/simple;
	bh=GqmnEqFun1TpYF0GkDkbOY73/EjCjs0RABH7y2eKWWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taKf2cWjekr+esAVt32Nt8rFL+qXI1yweOLem5zVLXO8q1vV04z8TYKIKsl8mZjCo49uA4h2KVYewmMvO6d39reZGnCuhWfNKR+VXOFaF00DwYyBMTME3CgfcawOrmWNHmGdXMEB9tPbHJbducKRwItaOLPVN5d2IHIzM+n4wBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f52RuXwl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f52RuXwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB56C19424;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327301;
	bh=GqmnEqFun1TpYF0GkDkbOY73/EjCjs0RABH7y2eKWWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f52RuXwlN+GwF0nKM6IjRBcF/73g+OccIS09DQ+q6S+PsE6wwl1MBaaCzyJSuOyJq
	 XNamtKlzFMepCAVaz1/2SSmJ2G15J8rBR6Mlme3SROvGX8XKbY5lx2frCYfLFn2Vhg
	 Z8KQkDQmdzvzm7rwIuO30F+lV6DBA7SVpoO2OPDctfOZj9DzKlIsnL5um0o5k/mWgN
	 vDjpfMYAedR8R0z7BJyI0VCPEFLCinT0GNUaRwXlslAq4TniKM0KIpTwIqTHAY/e7t
	 LdT0itmnsUYMLniQK8Q8Xz1hU6QdUlNs3DFFwR+N7pQdUiRSjRJju1IpSBpi2DHEG0
	 1FoQFgpMLdO8Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRD-00000008yBM-21a0;
	Thu, 12 Mar 2026 15:54:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/28] docs: c_lex: add "@" operator
Date: Thu, 12 Mar 2026 15:54:41 +0100
Message-ID: <ac00f8a4dd44475dd903cb9ca37f99a286bc9b30.1773326442.git.mchehab+huawei@kernel.org>
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

This was missing at OP regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 689ad64ecbe4..a61f5fe88363 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -100,7 +100,7 @@ TOKEN_LIST = [
     (CToken.HASH,    r"#"),
 
     (CToken.OP,      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
-                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),
+                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:|\@"),
 
     (CToken.STRUCT,  r"\bstruct\b"),
     (CToken.UNION,   r"\bunion\b"),
-- 
2.52.0

