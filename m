Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F1221555;
	Thu,  1 May 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142233; cv=none; b=QoTqsVphoJ6rht/duWNcBK2YUl6pd+RXc898qLlKrL+wjLzLIyVYFC7mOPrxEYpCXl2khhV+q0Ru4IovQfWZCMWiWSny1mI7fmFIKsFxJ5FUF4MvKbM9LuM0vw8p2NAZlEpIE6QIAcggtfy0HMNEaCKyF2OW6BbzTYI2gG9KA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142233; c=relaxed/simple;
	bh=On5UJDuuIt1L/XGDUZtnR1mOZhoQpq5RQPaGc48KlUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOQWEFoxzHEAj9+5QMFv/8l2tdvRfyqeSxix1xz/BYVmXwJwZE+vuM8ZTPeWAH7Fnlsg4EziKFE1PXWyX0Wje/OvrlhUpe0HnIV4PzK/vD+27ZaocDu78Zz+J+oGrPiAtWmuc1fqwDT4lAY7FwaTiVYT7JMsRag55Mjauia9buY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpUaK1Ow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpUaK1Ow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6D1C4CEED;
	Thu,  1 May 2025 23:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746142232;
	bh=On5UJDuuIt1L/XGDUZtnR1mOZhoQpq5RQPaGc48KlUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpUaK1Owmp4QUw2VM/3T5qQuVDKjR5PnnwI2O6yHjLW6uy6P/a4kU7gBT3eNqnt+4
	 WH2cEyvbhupUSCjuTdvdIN3WTI61BiKO38ZXHtnHMdD6tg0d227TPUYij8nHgh/lNG
	 z/Q7CA/hj9OqkEL9F55c6Av4nPxOX0Dg6Fmk81tVHgyEcF7bBIubLeoF4NmdTIcoXK
	 TLWbC+2UJLFyX6tEDTzh8c1w6N8Ej/WjF3cE6oYLn1tNIoOkvtjgL4pK6zMI0Ck6xp
	 /WMgwKtF8Y9iIvd5z4/2HGVTdVFu8Kc3mMKACRNLzA+xCBb+vecM1j9ah6vquCeNLt
	 WJwJHoYS/wubA==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] overflow: Fix direct struct member initialization in _DEFINE_FLEX()
Date: Thu,  1 May 2025 16:30:28 -0700
Message-Id: <174614222758.3007271.6106298572453987854.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aBP0b3gfurLFDlwY@kspp>
References: <aBP0b3gfurLFDlwY@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 01 May 2025 16:23:43 -0600, Gustavo A. R. Silva wrote:
> Currently, to statically initialize the struct members of the `type`
> object created by _DEFINE_FLEX(), the internal object `obj` must be
> explicitly referenced at the call site. See:
> 
> struct flex {
>         int a;
>         int b;
>         struct foo flex_array[];
> };
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] overflow: Fix direct struct member initialization in _DEFINE_FLEX()
      https://git.kernel.org/kees/c/d2e95bf39497

Take care,

-- 
Kees Cook

