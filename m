Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E92D97AB
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792961; cv=none; b=mojDPg+QSmKn3dU2tZ6uGrPcf+45LoAv03+bnaQoZK/QWckXLHQawNnlLh346i9WZirlVohr9jvHeGMA7NxzmAb7RujH8xO4izF0/vEOfa/Wkk6u47X+1/1nMs05ubwnwfiXSL9R+X+9wYwnE/nSSduBatyR9zW9vXq4i/1qLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792961; c=relaxed/simple;
	bh=9Wl1xXoOWbP8dypDvWcwf8bR+F9c5uAZ8pfGj0vPueY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr0w1u8YlIkdm/kAwg+kECRkFjdOLFTWD8MPy2g12sgCA4htYLBNsifzLdZrL8b9cJv6X4i4dNnbrUQbXrRJey3M0soZ2OQE5tvasnGnOTz1AF3RneTHEI8/Iv23ZmpDlrHvugxx+mll8ZZLCjHVWF5GbC+O0Urul5XrZIyTvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjE8GSwk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjE8GSwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C967FC4CEEB;
	Thu, 21 Aug 2025 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792960;
	bh=9Wl1xXoOWbP8dypDvWcwf8bR+F9c5uAZ8pfGj0vPueY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjE8GSwkwHP/Bu8pQvhRILXuAHMem3OFBLcsd9YZYRahKngu8onFQ7+mUtZ5cI0ma
	 Zv7H5XFsvUPOcmng94e8Rf71H53UyJBnI31bZHYUq0Jn7vifnSRzHbBgWw6iX3Mvf2
	 Vc9BF3dgY6SKYc1GcqkdgYeCLzPJUjoXHXOlF9LgGBAOrVsqO8sy6f60fDeDSghjkX
	 aWEfsNTsghSGzzvqCAALalmQXpSurwXx2L9gwYYu8tAROhvg1QAWoTX9TDOLqDtVJ2
	 cXT6IZq5yOYycFYO1Er2A9BC5deMbSrRJISMnX5oxQqYlrDCC9p/Xzs8LAbIQGoKpq
	 DohQHE0yLLnaQ==
Date: Thu, 21 Aug 2025 09:16:00 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Message-ID: <202508210841.8BE6E3C117@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>

On Thu, Aug 21, 2025 at 12:59:06AM -0700, Andrew Pinski wrote:
> On Thu, Aug 21, 2025 at 12:41 AM Kees Cook <kees@kernel.org> wrote:
> 
> > To support the KCFI type-id which needs to convert unique function
> > prototypes into unique 32-bit values, add a subset of the Itanium C++
> > mangling ABI for C typeinfo of function prototypes. This gets us to the
> > first step: a string representation of the function prototype.
> >
> 
> Can you explain why this is needed? Also it seems like the code is very

As you suggest later, this could just twiddle hash bits instead of
building up a string, but I left this as a C mangler in case it might
be useful in the future, and for debugging. Trying to figure out why
certain prototypes got mismatched was super frustrating, and looking at
a hash value was pretty meaningless. :)

> sensitive to buffer overflows. Especially the way it is currently written.
> The C++ front-end version uses obstack_grow to overcome the buffer overflow
> issue.

Oh nice, yes, obstack looks perfect for this. (Or as you suggest below,
std::string).

If keeping the mangling string output is unwanted, maybe I could use
obstack when the dumpfile is active and report the string+hash at the
end of mangling, but make the actual output be the hash value?

> > +    case BOOLEAN_TYPE:
> > +      **p = 'b';
> > +      (*p)++;
> >
> 
> I am not 100% sure this is always correct. because there could be a boolean
> type with a precision non 1.

AIUI, the non-1 case isn't possible on the C end of things and since
this is strictly for C type representation, it's good as-is. But maybe
I'm missing something?

> > +      else
> > +       {
> > +         /* Fallback for other real types.  */
> > +         *p += snprintf (*p, end - *p, "f%d", TYPE_PRECISION (type));
> > +       }
> > +      break;
> >
> 
> You definitely miss NULLPTR_TYPE.

Isn't nullptr C++-only? I don't think I can create a C type that ends up
getting internally mapped to NULLPTR_TYPE.

> > +
> > +    default:
> > +      /* Unknown builtin type - this should never happen in a well-formed
> > C program.  */
> > +      error ("mangle: Unknown builtin type with %<TREE_CODE%> %d",
> > TREE_CODE (type));
> > +      error ("mangle: %<TYPE_MODE%> = %d, %<TYPE_PRECISION%> = %d",
> > TYPE_MODE (type), TYPE_PRECISION (type));
> > +      error ("mangle: Please report this as a bug with the above
> > diagnostic information");
> > +      gcc_unreachable ();
> >
> 
> This is wrong way of doing this.
> It should be a sorry or a fatal_error instead. Maybe with an inform
> beforehand.
> You might also want to use get_tree_code_name, GET_MODE_NAME instead of
> printing out a number because the number tells nothing.
> Maybe even use print_tree or print_generic_expr to print out the tree
> instead of manually printing it.

Ah, perfect; thanks!

> > +    case ARRAY_TYPE:
> > +      /* Array type: 'A' + size + '_' + element type (simplified).  */
> > +      **p = 'A';
> > +      (*p)++;
> > +      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
> > +       {
> > +         HOST_WIDE_INT size = tree_to_shwi (TYPE_MAX_VALUE (TYPE_DOMAIN
> > (type))) + 1;
> >
> 
> No check to make sure array type is not a VLA. So this will ICE.

Oops, yes. Thanks!

> > +  else if (TREE_CODE (fntype_or_fndecl) == FUNCTION_DECL)
> > +    {
> > +      tree fndecl = fntype_or_fndecl;
> > +      tree base_fntype = TREE_TYPE (fndecl);
> > +
> > +      /* For FUNCTION_DECL, build a synthetic function type using
> > DECL_ARGUMENTS
> > +        if available to preserve typedef information.  */
> >
> 
> Why do the building? Seems like you could just do that work here. Also
> doesn't FUNCTION_DECL's type have exactly what you need?

I need the function prototype in three places:

- address-taken extern functions
- function preambles
- indirect call sites

At indirect call sites (during the early GIMPLE pass), I had a
FUNCTION_TYPE available that still had the full typedef information,
and I could use it fine. For the other two, it's later on and the
TREE_TYPE(fndecl)'s FUNCTION_TYPE had lost the typedef information (which
I need to be able to examine in cases where the typedef name was needed
for the mangling vs looking at the underlying types).

> > +      tree parm = DECL_ARGUMENTS (fndecl);
> > +      if (parm)
> > +       {
> > +         /* Build parameter type list from DECL_ARGUMENTS.  */
> > +         tree param_list = NULL_TREE;
> > +         tree *param_tail = &param_list;
> > +
> > +         for (; parm; parm = DECL_CHAIN (parm))
> > +           {
> > +             tree parm_type = TREE_TYPE (parm);
> > +             *param_tail = tree_cons (NULL_TREE, parm_type, NULL_TREE);
> > +             param_tail = &TREE_CHAIN (*param_tail);
> > +           }
> > +
> > +         /* Add void_type_node sentinel if the function takes no
> > parameters.  */
> > +         if (!param_list)
> > +           param_list = tree_cons (NULL_TREE, void_type_node, NULL_TREE);
> > +
> > +         /* Build synthetic function type with preserved parameter
> > types.  */
> > +         fntype = build_function_type (TREE_TYPE (base_fntype),
> > param_list);
> > +       }
> > +      else
> > +       {
> > +         /* No DECL_ARGUMENTS - use the standard function type.  */
> > +         fntype = base_fntype;
> > +       }
> > +    }
> > +  else
> > +    {
> > +      /* Must only be called with FUNCTION_DECL or FUNCTION_TYPE.  */
> > +      gcc_unreachable ();
> > +    }

Thanks for looking through all this!

-Kees

-- 
Kees Cook
