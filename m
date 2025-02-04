Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B218A6D4;
	Tue,  4 Feb 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691322; cv=none; b=iwKX7Jf2UwZQFi5ICsRHF2Am8byqZzwSo//F6Qr4XdFsHgN6mGMkUG4EAbImq7kq1NERBQkCrXUWKc7R/WRBM9ubctZ+BeoiQmgK08iRO0hL2dL6/8bT+AO81okRYVH+6OnsJqlevXomhy1hn6LETL/wUC0ORdMGLTYdvNcfdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691322; c=relaxed/simple;
	bh=2xAbvKVQOlgEgoQp8Nlu07gLHIrizjhQuSzWv5pzWew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icT7k88kw/9a+JKiPl10GQ8wllTiqrawEIacUaNFD4f5Pe67dt+TWAvY7TRUb3kNAUgy0PVps8mwa2CdCkztMnHOScjS8tVCWH6iApZGoFjZX84/3pDLnJQOvSmNsrpaoM2+EtralpHoFTDx7xVHriql8YRClMNk/TlJZxF+ryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGZXhgdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGZXhgdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7EBC4CEDF;
	Tue,  4 Feb 2025 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738691322;
	bh=2xAbvKVQOlgEgoQp8Nlu07gLHIrizjhQuSzWv5pzWew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGZXhgdwvzRU7HNj/+7l710B6du1I+vFwB/8dD37mg5vrSfKmzKQNkA/cEJhrsIu/
	 0mmNuJCpS+zPkIgJ1Jn5P+/ZulGLzAAEJaqo59WiI/IdriCBJpbNBs2kTaGdY39To7
	 JB8RJsqKQ+TaWfY8gViQWpBN8z0wiV8vwJ3hdbjdNZ8TZJHbqeTY3McBDb3LjTorQB
	 BSpjfmeekrJMb2uEc8uM+X0VO2kVimWI2TATGqB5DWE5gFPdH0VU1oavHih+z3KTMd
	 4Q47F65CkeMDNRoI6WYzhl625RjuKrcwdb0vSzshlao3CiXPh7C1tk9gmlK8yGOYlZ
	 ybT8diKmglrpw==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stackinit: Fix comment for test_small_end
Date: Tue,  4 Feb 2025 09:48:35 -0800
Message-Id: <173869131286.3463318.2294590080826557416.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3f8faa2d7d0d6b36571093ab0fb1fd5157abd7bb.1738593178.git.geert+renesas@glider.be>
References: <3f8faa2d7d0d6b36571093ab0fb1fd5157abd7bb.1738593178.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Feb 2025 15:34:07 +0100, Geert Uytterhoeven wrote:
> In union test_small_end, the small members are three and four.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] stackinit: Fix comment for test_small_end
      https://git.kernel.org/kees/c/28d00b3e5953

Take care,

-- 
Kees Cook

