Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD621635C7
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594905; cv=none; b=LYbq4Qz8pHwkL8EKP/MLwMl0b8sJjkCDaeTpxds9QFij+UoVShDx4Ayz59zqz479UgGaIBrMJr7wb0VpU4PxBI80SuUaB8ZF+0+OtzF0z0Vc6+bOTSP1lJwzWlFezahTR37eRNePEfSM82laM+E7JG7c5ES1rcjfBMQB5i7VIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594905; c=relaxed/simple;
	bh=nPUrAToma1+IWJyW4NorUHWTJxgN7XpkT+ZRrxLkDoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaTUsDoITPL/rRo1ZgSxdqRnrW+Wc4BGzR1A1w7kB2NTrcdOq0+bg8w3zojGy2l0KTArDkoSIqb8avVdNfAKbAeFivP7MF1lYIihjqP4wo6pWdNJVbAwnymLp30KKvqIwcZjb/P0MCHsP+SuNyD4soxCYaeGa6oerBvPvVs7TLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R6lC+wyy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R6lC+wyy"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f30f69a958so6197478b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714594903; x=1715199703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9pWF4P+vg6CtGHnRoqbJlxCPNRuZaXK34HOYWDy6qo=;
        b=R6lC+wyyKGv555bfAgjGaVAhVKeXMz7DYH5NnAacO7JbE3z4cYvgn7VrA7W78G9SBC
         S7iBlI75R5bcbxhAp/NRCcdjk5sPlNqJlXepxjuhYdqashwgMIqfeWXynm6eKpV590fm
         yZNlK1OerSDiXNTARj6eGB6JQvl7NcJ1kAGF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594903; x=1715199703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9pWF4P+vg6CtGHnRoqbJlxCPNRuZaXK34HOYWDy6qo=;
        b=XSDb1D3FNxzIpQolMderAxrPHkPfVZBnLLFs4+wLhNrq0Q+ofCkDRu7SXj500ESb+W
         BR7EfHLuAPLbGX2AX5aG3Z8HfAHeb69YtIq/MG7HFwQlxGUR1NY26YrxI6HL32UzkkMK
         u19SPHNjcDnGm7t1g5BQ6hpZN6IVerso+xtC1h1aTTwLxF1SVvarqqqDw3NrA49SOtsO
         11zfee3iOXRGjylKd9BI8skvHbnE+ErSvVM0aFO7QrlEFuPgUH7HOegNvhfxfZFoHt0D
         H3xhxu0DUkIT14YV6Yjskimn0SNlZMl+OPpqpXmHZJf16on1vM5VhSCwAzeeIR7v+/7n
         fmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkIxtyzfvQ8MUFT/BYmqfgJ9A1qcqYB4lt/0g8F0jTW86dW0NYbrxWIxxJNewr3M+TRIAmYU0B0G601W92+E225/dgL9ulD8M4fKEQKFRl
X-Gm-Message-State: AOJu0YzGK9aLDFrC8/FrGAUWBWIlS/N7B4L93wLOH47j9xd9N8SNYuBl
	T5g9J1a9oCWfmvc4R5WxI2S2ys1JC6SWjh+x5LplCgG3UCDXZvdAXEhj42fqXA==
X-Google-Smtp-Source: AGHT+IGyvJ8Fbk39B3YR+oN/YqBuq3FvOn0WZU33SvV3xChl0KcHhy12+GnrIWpDME/qQK5QKb0o9w==
X-Received: by 2002:a05:6a20:9f88:b0:1aa:5b05:7926 with SMTP id mm8-20020a056a209f8800b001aa5b057926mr4987182pzb.39.1714594903411;
        Wed, 01 May 2024 13:21:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r13-20020aa79ecd000000b006ed045af796sm22947779pfq.88.2024.05.01.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:21:43 -0700 (PDT)
Date: Wed, 1 May 2024 13:21:42 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <202405011317.AF41B94B@keescook>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240430091504.GC40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091504.GC40213@noisy.programming.kicks-ass.net>

On Tue, Apr 30, 2024 at 11:15:04AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> 
> So personally I detest struct_size() because I can never remember wtf it
> does, whereas the code it replaces is simple and straight forward :/

Sure, new APIs can involved a learning curve. If we can all handle
container_of(), we can deal with struct_size(). :)

-- 
Kees Cook
