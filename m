Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rKTS41f1"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56860111;
	Mon,  4 Dec 2023 21:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=7oP9M9pD0RDSc4w0bjKqb/w4dW1Xx3W26GU2jvw+iIU=; b=rKTS41f1+OGLLFOZ9Et7swhRZo
	kFeB6DxFQ8NhyVTVuczLyRt/HHswaZMdWnLpp1wNcufQJHdmSW7qxpej6JSyhscMZqBmM5YMZQIKr
	YO0TX1CF/N6ktx9rxADIp/Kz3gBcFB9aHCqhgDYZyuSOmTH8rJEnBlcJAtHEi6dwMfXw2UQvd5EeE
	xop9Qvkr2eXW9tfjh9BqPQ9kHYtdvBTiDzyP4w1BOiD0mcT1YZQbChwoNTpaNln0hMNvraaTe+F9T
	yRMFaJbABzAopmPj1byel3vuhXTON+JMLoRrHNNlhekEBEJgizfd6bN+02xxXvxnrtkeMLTz6quL/
	ZuSTHKJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAOJy-006Kyt-1J;
	Tue, 05 Dec 2023 05:50:14 +0000
Date: Mon, 4 Dec 2023 21:50:14 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> Tested by booting and with the sysctl selftests on x86.

Can I trouble you to rebase on sysctl-next?

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis
