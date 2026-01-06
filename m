Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1C21D5BC;
	Tue,  6 Jan 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730889; cv=none; b=U2o4HGAa/IC4+ervBxVwNWFIHmiXKFfu5uf8InfOqVO3fIc00W7iEXfnR5phWFnJqlJEtomfP4uNtxV4t4+Za/AGHSS2RHPuY7Gn1Pz83zkktUCa5zaSIq8vAxGHyMLUJQ4niVckZdeCO4bdTlw/9Kj/B7LXKLWQTgSwWoEj4W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730889; c=relaxed/simple;
	bh=6GymsSAJrMjlRhgGj673uy56XTGzYQmCI3sPLDhWRlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxEIkkvu6aOh3EiWyNisgHHYr1z/AUmXgA+p4Pija3aAZFkWDKNVfaYqChjeUYd3ssXI2hP+xOt8wVxizD5acOyMLTXxIan2/nLNvm8kqw55idppH2ce9Do6x115eQVa1PMvtuxxg77u3H7nrnH3u7+2m6WK+oAGT2J67vt/oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxB15hbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxB15hbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1741DC116C6;
	Tue,  6 Jan 2026 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767730889;
	bh=6GymsSAJrMjlRhgGj673uy56XTGzYQmCI3sPLDhWRlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxB15hbUwXzN9cJRtD1xTuBJosvLrbTIfgPCQf7gYa6tjI6u1IfBGUtNSSDG64wOm
	 o/8YuOAJqiOxUYR4jpglpx5BIq/Yg1do4jX1qYjAGxQ+dMn1M8ijTiVPVOzcvOku3e
	 fUB5qAsw3B4U6PPdcE7j+wlBXqgGMbyk5y/aljODx6Fq5Hxlcoc/6MKShaoqlK9o3h
	 Pf5RVEpEPCqvgG7Bq/lkg38nfMV9kQRgdYu34eDf9FI6R8QaC0pPPHzZwgDARJBcpF
	 +lEoGdK+14id5uZqBmWtYnOwYXD8wwgDwYsCaUD3I0qFmLvIwRjdYCGQkHbGqtpdwt
	 OeClmWJQxAe4A==
Date: Tue, 6 Jan 2026 12:21:28 -0800
From: Kees Cook <kees@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <202601061220.EDD0476@keescook>
References: <aJ17oxJYcqqr3946@kspp>
 <e1009d16-cadb-4446-aef5-4a52197551a4@embeddedor.com>
 <b4e596b0-4e6d-40b8-933c-f407f2cc0980@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e596b0-4e6d-40b8-933c-f407f2cc0980@kernel.org>

On Tue, Jan 06, 2026 at 09:14:36PM +0100, Danilo Krummrich wrote:
> On 1/6/26 7:08 AM, Gustavo A. R. Silva wrote:
> > Friendly ping: who can take this, please?
> For some reason this patch wasn't tagged for applying in my inbox -- seems like
> it slipped through.
> 
> I was about to pick it up, but recognized just in time that Kees already took it
> through his hardening tree.

Ah great!

> Sorry for the delay; thanks Kees for picking it up. Even though already applied,
> please consider this patch:
> 
> 	Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks! I had figured it was slipping through the cracks so I snagged
it. I'll add your Ack. :) If you'd rather take it, just say the word and
I can drop it from my tree.

-Kees

-- 
Kees Cook
