Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819894;
	Tue, 28 Nov 2023 13:42:44 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: dan@danm.net
Cc: linux-kernel@vger.kernel.org,stable@vger.kernel.org,toralf.foerster@gmx.de,linux-hardening@vger.kernel.org
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference,
 address: 0000000000000020
In-Reply-To: <20231128213018.6896-1-dan@danm.net>
Date: Tue, 28 Nov 2023 21:42:03 +0000
Organization: Gentoo
Message-ID: <87jzq1lflc.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I suspect this is https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
and the patch at
https://lore.kernel.org/linux-hardening/170117162434.28731.12930304842635897908.git-patchwork-notify@kernel.org/T/#t
may help.
