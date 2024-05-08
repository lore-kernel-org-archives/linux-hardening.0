Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44B39AD6;
	Wed,  8 May 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196280; cv=none; b=LuEPh7uicQohgH6ltatAEfUUIPtvVzdnFC6boZyNOxShfSIHj7vOW1MbritfxcC9ucF3SSWr7lyzdHL5fMvJmpoLs+p1whK5BU9/gumZVACRpTHPiGPjJfO+vO86DaBBcpweiczMv+hCuQY7YG4mN9DL7HyrYuhfkffnBc/gcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196280; c=relaxed/simple;
	bh=IxQvgPmgqvt1W2MNYCF0styePJc7qBXetU2bWXytcRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj4N6X9ovskBU48SGC5Nj7yYgQzYaCJaZIpFhktZee2LVssRLEA0Y8r5d0tAxQfXRnPgBxXjdLIbiIjY4I6H9SZjnKvCLZAnn418OKxsjXqFyCDYkz1YbpmQ9cjI5Q4A/g7L65zuYyuPQQEYUyyQ0dQAoeDZyW6kb5As6cBYl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ci0gTTo6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ci0gTTo6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=ulrzSmrw7Zq83YaNo/M6D4Z0aXmFCdVRkIPUItHKpVw=; b=Ci0gTTo6WXYrQq3a6RTj09QWEP
	Cy9kD+wEfpeCxP97h2gcknIMQw+psyT3U6g+sojclEo3mEgsxMgOIPaD4WvQcTn/XJJb9ek9o4GMM
	RIrefovBeaeCxJhs56J2qydxEPy62I1KibtpV+0z4t2ltyan6I0HcDFS1LDYZgl0Phs9EgyPk6QBn
	/hdIV18jxz8bFOT3jYaqzCdtLDqXGOaP9SSpAP/3UGjOsBtGmdqZf8w5mUqp3G+Za727q+c1NuBy7
	AAONB1e9jzEaMdCYyV0C7Wq9uwBFtc+iUwZiQW31rMaFNbDt13z7RyWo8fKjkJJhQSUoJog4bxFNX
	yEEx0c+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4mu4-0000000Gihs-0dBn;
	Wed, 08 May 2024 19:24:36 +0000
Date: Wed, 8 May 2024 12:24:36 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Joel Granados <j.granados@samsung.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seccomp: Constify sysctl subhelpers
Message-ID: <ZjvRdASCXUpgHANU@bombadil.infradead.org>
References: <20240508171337.work.861-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508171337.work.861-kees@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, May 08, 2024 at 10:13:41AM -0700, Kees Cook wrote:
> The read_actions_logged() and write_actions_logged() helpers called by the
> sysctl proc handler seccomp_actions_logged_handler() are already expecting
> their sysctl table argument to be read-only. Actually mark the argument
> as const in preparation[1] for global constification of the sysctl tables.
> 
> Suggested-by: "Thomas Weiﬂschuh" <linux@weissschuh.net>
> Link: https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/ [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
