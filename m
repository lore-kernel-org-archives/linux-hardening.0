Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCB36AE7;
	Thu, 28 Sep 2023 11:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293FDC433C7;
	Thu, 28 Sep 2023 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899496;
	bh=Z72NaU1k+yn8VH2KLYdJDMnZnUKhBkDyH6n6KvVEpYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ou0HLEYeDRVJuqY0rrG0SmdACv18zyLqyFfvqTO08uOxosewXkrdnUsKZDt4by03d
	 HoyzUC8RESyHsElFy2zn11j09IfZUt6WzHuA2oqO21Ha42SO+KKjXgm6IjLM41ZaXH
	 ZwhiFHQ85UyL+kbBBWakHtQDlKvxSMcDdKQpxgpwCi9X21uHcAKc3G/bOFNdpEQoHk
	 WsdW7mwVvcDmZgiZTnsgMjtrxUa+KpRrLwckKsmw0eTY9s/J352bE6VAvbfbcH27CW
	 a0Gd96itZ8C/fo/0yF0lAtKeo0IL63XfzQLgdegH0q4vvzaFAgyWcriGEs8NCPla5Q
	 foBo5T0e+9G9w==
Date: Thu, 28 Sep 2023 16:41:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Zhou Wang <wangzhou1@hisilicon.com>, Jie Hai <haijie1@huawei.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Green Wan <green.wan@sifive.com>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jordy Zomer <jordy@pwning.systems>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/21] dmaengine: Annotate with __counted_by
Message-ID: <ZRVfYzrdAOrXJUcI@matsya>
References: <20230817235428.never.111-kees@kernel.org>
 <202309151307.F3341BD5A@keescook>
 <202309221015.AB63726@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309221015.AB63726@keescook>

On 22-09-23, 10:16, Kees Cook wrote:
> On Fri, Sep 15, 2023 at 01:08:30PM -0700, Kees Cook wrote:
> > Just a ping on the series... how do these look to you, Vinod?
> > 
> > If you want I can carry them in my tree. Please let me know.
> 
> I'm now carrying this in my for-next/hardening tree. Let me know if
> you'd prefer I drop it.

Sorry was busy in travel etc, it should be in dmaengine/next tomorrow.
You can drop it

Thanks
-- 
~Vinod
