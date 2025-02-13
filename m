Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6418784A;
	Thu, 13 Feb 2025 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462658; cv=none; b=H4PD7H0i/eGlvsvdUB/gm2vo06Biqg2PVrJUUfsovFpmjShNfG0HGaPdTbWwSlVC3HCQ9G0vmWbfLRzgLq+kwio7NiHbmwCN3Aga1VuL2BtuR8GVw3ivft7a1ZTPRUjMbQXBI95Q2lZSPCbEA2tClIW5/42iMFZml71kNTWoHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462658; c=relaxed/simple;
	bh=0ppe+hGsKBjwi9+qUO7ATGSY7gr+M0GyA2Dpz7/PKB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwTzksdXcoQau49qHmQnYA85SBPaDZjKZMEXgb/2EvSdKnxhD+n7qmmZzZ1i+GkiD5KTi6XfF2fyPzgGcfK05wVjLIWmRFrmCLOQrBHL79jlqc4ypmshnVbCwRgHVXCIYQXFtY6kSAGGROjVjWYGynwmoSH3TseeVSIn6SNh1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFLLxWla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFLLxWla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DBAC4CED1;
	Thu, 13 Feb 2025 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739462657;
	bh=0ppe+hGsKBjwi9+qUO7ATGSY7gr+M0GyA2Dpz7/PKB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pFLLxWlaRUSWM3tDyxytg1FfQE7zjuO45pgUt4f0x0/xvuSeYmnYk2H4Hl2Kc0kML
	 H0gThPCl49lG2Nb3Tz/aCV/8ycYYJWEAv+24WBlmgY7WC0FgdDOiAZZfs36DBkTR5P
	 AIvcaP+teshSKpYLzztta5nV3BQ/ocjAY7swV0cvRThHUnlbdrH3xJHe5t9hUqhGN8
	 fahpF7zEx15NT3qu5mH1sbIN11/6xWcmW9cc6OmOPGqYnKmuVZmOKlTn/6BIKhZosi
	 pTdv/6UQayy7TGTmWTsoZbgq62hkvQsqun/OpK/YOQYddVp1YLMMAfrB5w7UAldIXz
	 S62JvdhfifUqA==
Date: Thu, 13 Feb 2025 17:04:13 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFCv2 4/5] scripts/kernel-doc.py: add a Python parser
Message-ID: <20250213170413.39caf2d7@foz.lan>
In-Reply-To: <59e3bb9ad6f9147c139ef4cc5500985e0bc847c2.1739447912.git.mchehab+huawei@kernel.org>
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
	<59e3bb9ad6f9147c139ef4cc5500985e0bc847c2.1739447912.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 13 Feb 2025 13:06:17 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> +    def dump_function(self, ln, prototype):
> +
...

> +            (r"""
> +              __attribute__\s*\(\(
> +                (?:
> +                    [\w\s]++          # attribute name
> +                    (?:\([^)]*+\))?   # attribute arguments
> +                    \s*+,?            # optional comma at the end
> +                )+
> +              \)\)\s+
> +             """, "", re.X),

Heh, funny enough, this regex doesn't work here (Python 3.13.2), even 
after removing the extra "+" on some lines, e. g.:

            (r"""
              __attribute__\s*\(\(
                (?:
                    [\w\s]+          # attribute name
                    (?:\([^)]*\))?   # attribute arguments
                    \s*,?            # optional comma at the end
                )+
              \)\)\s+
             """, "", re.X),

I had to fold it into a non-verbose/extended regex, e. g.:

            (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+", "", 0),


Thanks,
Mauro
