Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D11B87E8;
	Wed,  9 Apr 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215855; cv=none; b=j/97+lnosrLWxqfgGC9x31tvrcJCyWpRwB+sImBgBwROgO61fPEIy3eDsBhteySE+RKZVlqHKiH+6Gm6f4Ov1r6UsoTPx6Y/poNB8BrgSZyfXEV2tw4sa2REK2RU1In1e33puvhnvwGQNwuj42cLyEGnk9ulj8b7S7ZkPBZTINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215855; c=relaxed/simple;
	bh=kXs5F2Vc8xLJJ+CWx4LPbc3JMRVLeFS7hhCGdGHdNIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjtDj3WSYvGZrBkxJYyhRA52SpV0+/n0lHJOvknLNFCrs3q41/BQ140P+VKaUb280SIYwiennb+RTQXW34M8S28dW7bztNOu3lLm9DUzrvx80QcR7GHWG2eqYZaV2HEKKy2Gt6fFtfCkfVipUpI9mm/SH0xOozxMthpKaDpEFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE6VmE7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE6VmE7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86239C4CEE2;
	Wed,  9 Apr 2025 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744215854;
	bh=kXs5F2Vc8xLJJ+CWx4LPbc3JMRVLeFS7hhCGdGHdNIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QE6VmE7BKIZnG4io5vpJuuV78bcz+Jwb3tlM+ubs5l9UVLKnz0pqrWnN07kyxsnJB
	 gPL40V7xx6beXlJVoJNQBXHNpsZyfz9m2w/PehBX05sGxN0sWwJyIwZ4NdsrXQseH7
	 CUHL7wBFKoW66c6dvEfNygGd8nZLWelVRk+Qj2HpM6tDxaGEOf8FH3KRFIxSk9mSOq
	 72HBl14RXi+KX51Ie6G6hUZxYEnHsKucK2REGkoAV5guq+lT7+KROzXxMsRfCd447X
	 dHPfu+cLZDsaWqAVKGZs7cn2FZTfDadIK5V6Ff7xQ0m3xj4k5/M1KPBSgmHpk9CI/R
	 b3ITJVyTt9V8w==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alejandro Colomar <alx@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] EISA: Increase length of device names
Date: Wed,  9 Apr 2025 09:24:08 -0700
Message-Id: <174421584602.1131324.11481345172873893292.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407172926.it.281-kees@kernel.org>
References: <20250407172926.it.281-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 07 Apr 2025 10:29:35 -0700, Kees Cook wrote:
> GCC 15's -Wunterminated-string-initialization warned about truncated
> name strings. Instead of marking them with the "nonstring" attribute[1],
> increase their length to correctly include enough space for the
> terminating NUL character, as they are used with %s format specifiers
> when showing resource allocations in /proc/ioports:
> 
>         seq_printf(m, "%*s%0*llx-%0*llx : %s\n", ..., r->name);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] EISA: Increase length of device names
      https://git.kernel.org/kees/c/f891ec0e639a

Take care,

-- 
Kees Cook

