Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C928DC2
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0E13B43;
	Thu,  5 Oct 2023 07:21:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1A3967373; Thu,  5 Oct 2023 10:22:17 +0200 (CEST)
Date: Thu, 5 Oct 2023 10:22:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <keescook@chromium.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Message-ID: <20231005082217.GA12575@lst.de>
References: <20231003232511.work.459-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003232511.work.459-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 04:25:11PM -0700, Kees Cook wrote:
>  	struct workqueue_struct		*work_q;
>  	struct kref			ref;
>  	struct rcu_head			rcu;
> -	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
> +	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize); /* array of fcp_iods */

Please move the comment up to not spill over the end of the line.

Otherwise this looks good.

