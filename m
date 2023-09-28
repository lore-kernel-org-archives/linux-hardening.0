Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F75163;
	Thu, 28 Sep 2023 00:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8232FC433C8;
	Thu, 28 Sep 2023 00:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695861000;
	bh=9VotLMsBI791Z3ShJpdyU424mV4uO4FeE3QubwCoWCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Np2y57woLdUA6+YYern+0oWaH42mD0IB71IpVAbD2NIKSD3WRxkfGvnTrA1Rl5d+K
	 eoFoLyOs2rt9n1uC0K9ueitqVpLBMeFYd8RD69jdBjePfd6W+9gPL92MPqyH9LJ9K+
	 tuPwwRr/36zdZFQs22PBdD4tWI0Se4WAlAZ26Ghv88VCxMvol07cy5y2chOro/GuBc
	 KMjTA6N+XPRnQsSSfNIXRWB3fXdvi0redKorEkqfbArJ8ATVtk0ku5uCegiUjAIDb3
	 6EqC4q963ewtvQgw0j7QGl75HmosbUWszi8urAGP5uwSgk2rtw6i1Rh6/iTlFn/6Z2
	 n5OucDH7BYbmQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smem: Annotate struct qcom_smem with __counted_by
Date: Wed, 27 Sep 2023 17:34:04 -0700
Message-ID: <169586125035.1226038.13396484485587961268.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922175413.work.929-kees@kernel.org>
References: <20230922175413.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Sep 2023 10:54:14 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct qcom_smem.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: smem: Annotate struct qcom_smem with __counted_by
      commit: 433ce46a97116f431ee114b4607143860aad4054

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
